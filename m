From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: update-index --really-refresh unsets assume-unchanged bit
Date: Tue, 4 May 2010 12:41:22 -0400
Message-ID: <z2h32541b131005040941m79724daq4cd8b0c427bb218a@mail.gmail.com>
References: <20100501092512.GA15941@localhost> <20100501092720.GB15941@localhost> 
	<20100504085722.GA32217@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 04 18:41:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9LBu-0007N3-H5
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759756Ab0EDQlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 12:41:45 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:44915 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab0EDQlo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 12:41:44 -0400
Received: by ywh36 with SMTP id 36so1743941ywh.4
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4WRx3Bxq0tb2hevHYJHHip7TSxgSAotDT6ncmH0Kd/0=;
        b=OJYCLeFOhs7ii9/s+87EK7bcOxt5/1sAKqGtyJUCsYWnH5KruaxMlRznz1etlLqgf2
         STPcPwczVQPsaE1Hqz0vaHP1/LPJOjS9msO4r6MdY48eQHYYmEgftLb8IEzbQTK4AXpN
         CxZT1+BCWYP/f0N/nuIP1OJVzsmcmixc+X++4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BbISRkypxJNAHcLj3Cf55u1ZT0lNlpVl+kIHGsh9LSYHKrnHI8IjP5arg4m+fnAFfZ
         DbKEPp4HWjNBMlJUw7g0Zg5Ij/lKZ2C0vFRUDO+azA0bVaY9530GV6c8GpyHsRVNRRHj
         yiFYA9XHcvopsErMcBnmLfY3hpTrwaRA4Xh60=
Received: by 10.150.99.5 with SMTP id w5mr13092545ybb.139.1272991303321; Tue, 
	04 May 2010 09:41:43 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Tue, 4 May 2010 09:41:22 -0700 (PDT)
In-Reply-To: <20100504085722.GA32217@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146326>

On Tue, May 4, 2010 at 4:57 AM, Clemens Buchacher <drizzd@aon.at> wrote=
:
> On Sat, May 01, 2010 at 11:27:20AM +0200, Clemens Buchacher wrote:
>
>> =A0--really-refresh::
>> =A0 =A0 =A0 Like '--refresh', but checks stat information unconditio=
nally,
>> - =A0 =A0 without regard to the "assume unchanged" setting.
>> + =A0 =A0 without regard to the "assume unchanged" setting. The "ass=
ume
>> + =A0 =A0 unchanged" bit is unset for all paths.
>
> Scratch that latter part, please. I just noticed the bit is unset onl=
y for
> modified files. If the file matches the index, or even if it has been
> deleted in the work tree, the bit is _not_ unset.
>
> So the current behavior is quite strange. I see several possible
> interpretations of --really-refresh:

I don't know, the current behaviour sounds consistent with the name:
"assume unchanged."

If the index says the file is unmodified, then assume it's unchanged;
don't check for changes.

If the index says the file is modified, then clearly it's changed; it
would be pointless to assume otherwise, so the "assume unchanged" bit
should probably not be set.  (Plus it's quite possibly dangerous to
assume the file permissions are the same as they were when you first
noticed they were changed; imagine if the file has changed twice and
now has a different length or mode.)

Since most of the time most of your files won't have changed,
assume-unchanged gets you the optimization without too much danger.
The cost of not assuming a changed file is unchanged is pretty low.

=2E..now if only there was a global "just never check for changes or ne=
w
files or anything, even if I run git status" bit, someone could write
a useful git inotify daemon :)

Have fun,

Avery
