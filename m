From: Vicent Marti <tanoku@gmail.com>
Subject: Re: Libgit2 on the Summer of Code
Date: Fri, 28 May 2010 02:15:43 +0200
Message-ID: <AANLkTillXInFUGR0tYqlPbdddfQKPbGDbjPEV0voaBev@mail.gmail.com>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com> 
	<20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi> 
	<20100527180554.GM16470@spearce.org> <20100527183534.GA10414@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	srabbelier@gmail.com
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri May 28 02:16:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHnFG-000852-Mp
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 02:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab0E1AQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 20:16:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:40960 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab0E1AQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 20:16:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so256633fga.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qxemk2S5kPZPE6Q3f3I/1/o/KVCwqGH17HNK2SvbuNY=;
        b=YnNpofpny0ZmjkMzI53FnHFayWcRYlZf2LLIv0g9jSXENM5O17MiJg37ZNQT1eIj/n
         YMTX6N8csStY+30nn1rA5517NiWmNs00FsSy+2atIxZFPsvEGBXJbOVuTyhTaIgmFfug
         osu1Zqlax5fz56vFC1F/rS+Nj0ODMWW18zuCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XBiK31k14lrKwQFKfTOw4cLajJEQF2n5whwqqA5TAZ28hsg6YI4OIXzKNq9CJW9/IM
         p9woZKh42Cmk56vCKe6jDDujkPa48NAW+KtGeY12FpVpD3kk+GKHt5pAQjHBHjOKSqzP
         TOthJmk0d1Qy+Oh2RzY89Sujo/mscdNx59RlI=
Received: by 10.102.12.10 with SMTP id 10mr216501mul.96.1275005764239; Thu, 27 
	May 2010 17:16:04 -0700 (PDT)
Received: by 10.102.220.12 with HTTP; Thu, 27 May 2010 17:15:43 -0700 (PDT)
In-Reply-To: <20100527183534.GA10414@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147907>

Hey again,

thanks for the bites, Ilari. I've fixed all the formatting issues in
the latest batch of commits [1], and improved the error handling quite
a bit.

Regarding the hashing of OIDs, it's not a random hash, it's an
adaptation of MurmurHash [2], which is made of win -- specially when
it comes to dispersing stuff on hash tables. You are right however
that SHA1 raw bytes are already random enough, and probably not worth
the performance hit of hashing again on top of it -- I've dropped it
for the time being.

More work tomorrow,

Cheers,
Vicent Mart=ED
http://www.bellverde.org

[1]: http://github.com/tanoku/libgit2-gsoc2010/commits/master
[2]: http://sites.google.com/site/murmurhash/

On Thu, May 27, 2010 at 8:35 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Thu, May 27, 2010 at 11:05:54AM -0700, Shawn O. Pearce wrote:
>> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>> > * Where algorithm in git_revpool_table__hash() is from? Since it a=
ppears to
>> > hash binary object IDs, wouldn't just simple sum/xor over words be=
 sufficient
>> > (all SHA-1 output bits are very nearly independent). Or do you nee=
d to be
>> > compatible with some other implementation (doesn't appear so, beca=
use hash
>> > is computed differently depending on endianess)?
>>
>> If you need a hash value for a SHA-1, why not just cast the unsigned
>> char* to unsigned int* and load the first int as the hash code?
>> The output of SHA-1 is pretty evenly distributed, using the first
>> few bytes as an int should yield a sufficient distribution throughou=
t
>> the hashtable.
>
> Yeah, With pseudorandom function[*], all ways of reducing the output =
to n bits are
> at most as good as just taking first n bits. But if reducing output t=
o [0, m),
> the best way (distribution-wise, not speed-wise) is to take remainder=
 of the whole
> value divided by m...
>
> [*] SHA-1 is not pseudorandom function, but for virtually all practic=
al purposes
> it is.
>
> -Ilari
>
