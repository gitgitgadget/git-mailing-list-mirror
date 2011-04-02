From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 5/5] tree-walk: match_entry microoptimization
Date: Sat, 2 Apr 2011 12:54:39 -0500
Message-ID: <BANLkTinMoSBhG2d=JDhR5homsgn=_HB87w@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-5-git-send-email-dpmcgee@gmail.com>
	<BANLkTikZ=eH-Jdd-kdvw4JKPbqCr7kviZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 19:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6529-0002iY-6h
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 19:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1DBRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 13:54:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50218 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102Ab1DBRyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 13:54:40 -0400
Received: by wwa36 with SMTP id 36so5154722wwa.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UraERC2sGgsza18S0sXP2D100l39oT3W6HJY8ZEt6m0=;
        b=JBM/4nLw0Um3uYLpZ1Ze5dPYqPa1x4jiwHL0Xl3oa+BCB9iLVhuIGnCMOJW0bgEyti
         5E82seXXIWPass4B4I7goSTkBgYbBFkA5ctDCn81X58dN391Ft5JAjBG5yFHEBFZT3Mb
         ugzL4f9YLrzslfGtxxZTTpUi8mnpnI+S6vZ7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LCosOU02yi53uw0tfbEPkRniAI19B1KXhoFfJ3Zq/Lq3KaH33d5eM8iUMKG3cFer8R
         kY3Xbb4hk38phk6s0uNPvHWMfDRF1awqJxS2NLYBTNMus5HLkZE5g2UrvbScTPjxNwjB
         n4RJ6B5FDIN4GJP2nC1hXFOIfurgSg1rj1D8E=
Received: by 10.227.7.18 with SMTP id b18mr5374539wbb.103.1301766879242; Sat,
 02 Apr 2011 10:54:39 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Sat, 2 Apr 2011 10:54:39 -0700 (PDT)
In-Reply-To: <BANLkTikZ=eH-Jdd-kdvw4JKPbqCr7kviZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170655>

On Sat, Apr 2, 2011 at 4:06 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Mar 31, 2011 at 8:38 AM, Dan McGee <dpmcgee@gmail.com> wrote:
>> Before calling strncmp(), see if we can get away with checking only the
>> first character of the passed path components instead.
>>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>
> I wonder if inlining strcmp() would be better (at least cleaner code).
> It seems like you try to avoid the function call cost here.

100% agree with you, but I have no idea how to do that. Realize also
you can use memcmp() here; I tried that and got no noticeable gain
(likely due to how short these strings are). However, it is what we
use in most other functions in this file. I assume the compiler would
inline versions with a static length, but if you have suggestions as
to how to inline a non-trivial version here I'm all ears.

-Dan
