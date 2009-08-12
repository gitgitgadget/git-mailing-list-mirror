From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and 
	read-tree
Date: Wed, 12 Aug 2009 08:30:45 +0700
Message-ID: <fcaeb9bf0908111830n50bd4733h5033c6f13a45999@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-3-git-send-email-pclouds@gmail.com> <1250005446-12047-4-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-5-git-send-email-pclouds@gmail.com> <1250005446-12047-6-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-7-git-send-email-pclouds@gmail.com> <1250005446-12047-8-git-send-email-pclouds@gmail.com> 
	<2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com> 
	<m3ab26owub.fsf@localhost.localdomain> <2729632a0908111503i7f035c1aw4e84151eab821006@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 03:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb2gm-0002Zy-RJ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 03:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbZHLBbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 21:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbZHLBbG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 21:31:06 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:52013 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbZHLBbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 21:31:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so4440923and.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 18:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=F7P+E7m7Dc2gPR3xFP1F8AO9ZYxe3NpjCb5mJE6QZGA=;
        b=nwjCOggAnweoMEAoTAUIjnEhgDzj7UpYVQfjKMsQldjnpRq3EjhbxB6pvNTIYdZ4iu
         cRkjBBnk6SWjyc2wA5ZIYOmw9UsuZsqgu3U9eF/GoEmFk77oDuEiZZhcPr2AyVmWYq4A
         4gQfP5/ayMP3HqYwey3IRUME4JL1wcKQmfQN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gaFV/EslqgJE2BgRdwSlhqBppnxBV07KHyHn23SZqnOl4o/2pAjsCGVR+8NQMuC5fG
         vMAQ1klxFpbEDDd7G65P9oYwk1WVXjqjwsNmZX67BmAZrvlQolbBSnuckeSJrXkvhYjK
         JRP4VVlHUkpZVy9RmJCbomFMtYjS5pKAGJLE0=
Received: by 10.100.247.14 with SMTP id u14mr6341404anh.7.1250040665112; Tue, 
	11 Aug 2009 18:31:05 -0700 (PDT)
In-Reply-To: <2729632a0908111503i7f035c1aw4e84151eab821006@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125641>

On Wed, Aug 12, 2009 at 5:03 AM, <skillzero@gmail.com> wrote:
> On Tue, Aug 11, 2009 at 2:38 PM, Jakub Narebski<jnareb@gmail.com> wro=
te:
>> skillzero@gmail.com writes:
>>> 2009/8/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>:
>>
>>> > [1] .git/info/sparse has the same syntax as .git/info/exclude. Fi=
les
>>> > that match the patterns will be set as CE_VALID.
>>>
>>> Does this mean it will only support excluding paths you don't want
>>> rather than letting you only include paths you do want?
>>
>> Errr... what I read is that paths set by .git/info/sparse would be
>> excluded from checkout (marked as assume-unchanged / CE_VALID).
>>
>> But if it is the same mechanism as gitignore, then you can use !
>> prefix to set files (patterns) to include, e.g.
>>
>> =C2=A0!Documentation/
>> =C2=A0*
>>
>> (I think rules are processed top-down, first matching wins).
>
> I wasn't sure because the .gitignore negation stuff mentions negating
> a previously ignored pattern. But for sparse patterns, there likely
> wouldn't be a previous pattern.

No problem. We put pattern '*' at top (match everything). Previous
pattern issue solved.

> Include patterns are a little
> different in that if there are no include patterns (but maybe some
> exclude patterns), I think the expectation is that everything will be
> included (minus excludes), but if you have some include patterns then
> only those paths will be included (minus any excludes).

Let's say you want to include foo/ and bar/ only, this should work:

*
!foo/
!bar/

The evaluating order is from bottom up. When it first matches 'bar/',
because it a negate pattern, it returns "no don't match" and stops.
When it matches neither foo/ nor bar/ then it will be caught by '*'
and return "yes it matches" - that means "ignored" from checkout area.
In the end only foo/* and bar/* survive.

I think it's as easy as writing exclude patterns once you figure out '*=
'.
--=20
Duy
