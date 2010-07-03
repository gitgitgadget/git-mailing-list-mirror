From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Sat, 3 Jul 2010 09:20:05 +0800
Message-ID: <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
	<20100702192102.GA6585@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de
To: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jul 03 03:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUrPC-0007ax-Vi
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 03:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab0GCBUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 21:20:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41758 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab0GCBUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 21:20:07 -0400
Received: by wyf23 with SMTP id 23so1395302wyf.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gHc9xEM6MnT04G4RDPuDzjN/gdLo60ozNC3FMVUrIxw=;
        b=i7AcWB0wtlqKzqfja6fxDVOXDIuapnuO5BOufrU492OdXFQWtohHaKiDwhIkkdkjU0
         touQ/WknRpD8SP5tSLXYcH6lXH0pRskM9pYG0FFdRy3q7rqLSdlZzwqaCNV/rshk/rh2
         QO88zR/vWZIOPTTmRwROgpNsbkkJJlAvTLNTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G9aAzHH+wFedpDx4cqvAW7lRD2op7IezS/7nFKGfwE3hKZHAgpsPJatM1zYY8QlmE6
         Ytma97HwdopE1Haooy/gK+8r8lOcW5kjIkh3DYntUpRDJLA1Yqm5fHR6XlIGk+3WXIfG
         jRXVmsJhyP457RDqFOxMzV6dA6CwvbqI2KYMs=
Received: by 10.227.138.5 with SMTP id y5mr965127wbt.137.1278120005956; Fri, 
	02 Jul 2010 18:20:05 -0700 (PDT)
Received: by 10.216.162.213 with HTTP; Fri, 2 Jul 2010 18:20:05 -0700 (PDT)
In-Reply-To: <20100702192102.GA6585@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150175>

On Sat, Jul 3, 2010 at 3:21 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Nazri,
>
> Nazri Ramliy wrote:
>
>> When color.ui is set to auto, "git grep -Ovi foo" breaks due to the
>> presence of color escape sequences.
>
> I tried the following test without your patch, and it seemed to pass
> without trouble. =A0What am I doing wrong?

Sorry for not being more specific about the breakage. "color.ui" is not
enough to trigger the breakage.

You'll have to set "color.grep.filename" too in order to break the two
test cases.

Something like the following will do (I'm doing this in gmail so sorry
for any tabs<->space conversion):

test_expect_success 'copes with color.ui' '
 =A0 =A0 =A0 rm -f actual &&
 =A0 =A0 =A0 echo grep.h >expect &&
 =A0 =A0 =A0 git config color.ui always &&
       git config color.grep.filename yellow &&
 =A0 =A0 =A0 test_when_finished "git config --unset color.ui" &&
       test_when_finished "git config --unset color.grep.filename" &&
 =A0 =A0 =A0 git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
 =A0 =A0 =A0 test_cmp expect actual
'

test_expect_success 'copes with color.grep' '
 =A0 =A0 =A0 rm -f actual &&
 =A0 =A0 =A0 echo grep.h >expect &&
 =A0 =A0 =A0 git config color.grep always &&
       git config color.grep.filename yellow &&
 =A0 =A0 =A0 test_when_finished "git config --unset color.grep" &&
       test_when_finished "git config --unset color.grep.filename" &&
 =A0 =A0 =A0 git grep -O'\''printf "%s\n" >actual'\'' GREP_AND &&
 =A0 =A0 =A0 test_cmp expect actual
'

nazri.
