From: Emeric Fermas <emeric.fermas@gmail.com>
Subject: Re: What's the definition of a valid Git symbolic reference?
Date: Tue, 15 Feb 2011 07:32:11 +0100
Message-ID: <AANLkTimaYFbDsAooSuP+BBMA8mJYwupPCgJUj8UGqrQx@mail.gmail.com>
References: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
 <F624322D-359A-48ED-A241-622042F77CDA@sb.org> <AANLkTi=FKXqu_psoT+gvyq2c_o8Mej+DgpccecOpQd8H@mail.gmail.com>
 <7vsjvpq0jk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 07:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpESj-0008AK-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 07:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab1BOGcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 01:32:33 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62140 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab1BOGcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 01:32:32 -0500
Received: by pzk35 with SMTP id 35so953765pzk.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 22:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5fgPFfS2uCQtHG5kUyFVk0oqqgZV7s0NxUtp/KpgjLE=;
        b=liqA+Do7hOSXGnXCgNx7gjWq+xhNLigdTeOAq8tV+/Q0MxumPXLWAtiMzokY94Nx1o
         o7Dfx2wcd3e+lXe+4G+dFRAOHS28Su3/QrkHsNyy0EZIZUv/vFLbTgRVD3JPPKdDOyAN
         cjL1hVzBOfU8BVmJhoTvpO0DhmQ7YUiEdKuKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lBAJo2/FhKNQi6g7KW6OJF5Im4R+TpgjRO2JP93Fw2pjiG6wPq42nNIJhEqVR/FYj8
         vVOJ8ZmT4bwY5SWwKzgfhINvL3Dkpxxuo4quivTXpASl+Uay5f9Rf2pwPE26A+zA/dTf
         aUuGNlUjIbssBXNJL5G1Nm+yp9czrsQjqlCu8=
Received: by 10.142.144.2 with SMTP id r2mr3881940wfd.244.1297751551737; Mon,
 14 Feb 2011 22:32:31 -0800 (PST)
Received: by 10.142.195.18 with HTTP; Mon, 14 Feb 2011 22:32:11 -0800 (PST)
In-Reply-To: <7vsjvpq0jk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166813>

Thanks a lot for this very clear explanation. All my questions have
found an answer.

Cheers,
Em.



On Tue, Feb 15, 2011 at 7:22 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Emeric Fermas <emeric.fermas@gmail.com> writes:
>
>> Once again, by reading at the code I can understand how those comman=
ds
>> currently work. What I'm trying to achieve is to understand what
>> should be their recommended usage.
>
> There are only two valid kinds of symrefs right now:
>
> =C2=A0- .git/HEAD, pointing at somewhere under refs/heads/ hierarchy;
>
> =C2=A0- .git/refs/remotes/<some remote name>/HEAD, pointing at somewh=
ere under
> =C2=A0 refs/remotes/<the same remote name>/ hierarchy.
>
> The code may be prepared to resolve recursive symrefs, symrefs other =
than
> the above two kinds, symrefs that point at elsewhere, but all of them=
 are
> outside of the design scope of what the mechanism was intended to sup=
port.
> What the code do to them (without crashing) is not the design, but si=
mply
> an undefined behaviour.
>
> This won't change very much if we decide to reorganize the remote tra=
cking
> hierarchies in 1.8.0. =C2=A0The former won't change at all, and the l=
atter will
> start pointing at refs/remotes/<the same remote name>/heads hierarchy
> instead.
>
> I vaguely recall tg abused the symref mechanism to point .git/HEAD at
> funny locations; it may still be doing so, and if that is the case we
> should extend the above list to cover that usage.
>
