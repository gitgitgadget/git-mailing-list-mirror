From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Thu, 25 Jun 2009 01:31:44 +0200
Message-ID: <cb7bb73a0906241631h6ad03867i796b658abc425896@mail.gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v63elqoig.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com>
	 <8c9a060906241606x281f4d33ne5e4999a50ee8128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 01:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJbwX-0004Da-AX
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 01:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbZFXXbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 19:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZFXXbm
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 19:31:42 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:44041 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZFXXbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 19:31:42 -0400
Received: by bwz9 with SMTP id 9so1077495bwz.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E0VUNS2ghhtIm73s0b2KTI+QsWeBkXpl7+Rf7XYU9lI=;
        b=f+qRz49UMszFLcdS+U3zj973S+3xXqIZpKlHY4uOCnxQyhNFk1AdpY56Xt4qm+yD11
         tqiXlospfvmJgVG1nCEBItY2TwyiOsTkJN0vt8WqQW1JCwP5Cd9E0iAthmG9SLsAPlHO
         pAlnx8EWgjZbZCQT01RcUOZ6vLE8uWr4UGQKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hx2hvmveQ6osAjg8sAH1oUvJuRgqxdkxjfbdNxzhY0/V2VtVfgKAFPVrsiQTlPDyNT
         OGVR+FJp42C+OOglnbshqyOCKdQu++PXseyN17asTKvmz34G9gqexwoP/uuD6AgAKiU9
         BUBRVDbcfbQvfGgS5MzfFdtI6PPEN8QYPWtPc=
Received: by 10.204.59.14 with SMTP id j14mr1844814bkh.39.1245886304062; Wed, 
	24 Jun 2009 16:31:44 -0700 (PDT)
In-Reply-To: <8c9a060906241606x281f4d33ne5e4999a50ee8128@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122168>

On Thu, Jun 25, 2009 at 1:06 AM, Jacob Helwig<jacob.helwig@gmail.com> wrote:
> On Wed, Jun 24, 2009 at 15:46, Giuseppe
> Bilotta<giuseppe.bilotta@gmail.com> wrote:
>> On Thu, Jun 25, 2009 at 12:02 AM, Junio C Hamano<gitster@pobox.com> wrote:
>>
>>> I think the cache is placed at the wrong level (it doesn't have to be a
>>> GRavatar_url_cache, but can be a general avatar_url_cache).
>>
>> I'm not sure about it. The URL depends on email and size (can you use
>> arrays as hash keys in Perl?) , and the email part might be the same
>> but the size part might differ across separate calls (in theory; in
>> practice avatars in a view are presently all the same size; but for
>> example if we were to autodetect email addresses in commit messages,
>> we might have both single- and double- sided avatars in the same
>> page). By hashing on email+size only we would lose the benefit of
>> cache when using the same avatar at separate sizes.
>
> You could have a hash key of "$email_$size", or something similar to
> fake an array hash key.

The point is not so much the form to give to the key but rather the
fact that hashing on both means the URL has to be recomputed when the
same email appears with both sizes. Considering that (at least for
gravatars) the computational intensive part comes from the MD5 of the
email, this means a waste of cycles.

By letting the cache be per-avatar, each avatar kind can choose to
hash on whatever it needs to. But I got an idea on how to improve on
this.

-- 
Giuseppe "Oblomov" Bilotta
