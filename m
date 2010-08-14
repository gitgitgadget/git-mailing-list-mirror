From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 21:41:44 +0000
Message-ID: <AANLkTimLHand0g965TJmk=Y4Q+0uTFovZZRZXf9Fx4UB@mail.gmail.com>
References: <20100814131156.GA24769@nibiru.local>
	<20100814210556.GB2372@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:41:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkOUC-0008Pu-15
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab0HNVlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 17:41:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58929 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0HNVlp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 17:41:45 -0400
Received: by yxg6 with SMTP id 6so1510806yxg.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a+vlHP8aKBqJTYcZwdPY+sfRa9LBpJprVoc53qBuQ9Y=;
        b=eBBcF3YnNx8xtNs7Il13blIL/0CfOrGbUZQPNqx7Tigloum3KFN4KWucPaOvnq1g4g
         SjQJt74mSNvW2NrLBHBUfj/OhL/Y1823FzYJC1lhP38M6iLLbrOkiQdFORgpCoi5gun2
         C4kfU3ytcbcpqqOxGGj55I60T4Y8s5NqNcUbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BZFv2pE7v/G8JMLgcN3WYavGWj50k4SDK5G+F8gBcGXwKQUV0RJ0BHknJcHymKGs0O
         5SYmm1AgxemEUCw3ZginkMnbNE0YZv3Jah0tdETJGFvUOGFeKNStdhMezW6c1WT0WcQB
         wZF1eYwxsz2qi3ezO4okUsk1SxBwQgL/6MHHQ=
Received: by 10.231.12.77 with SMTP id w13mr3425810ibw.129.1281822104920; Sat,
 14 Aug 2010 14:41:44 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 14:41:44 -0700 (PDT)
In-Reply-To: <20100814210556.GB2372@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153584>

On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Enrico Weigelt wrote:
>
>> are there some flags to make the maintenance commands like
>> git-repack and git-gc silent, so they only output errors ?
>
> Does --quiet work? =C2=A0If not, patches would be welcome.

I intentionally neglected to mention that. That inevitably leads to
cases where something fails, but you didn't record the output.

Instead (copy/paste from a recent post of mine to an unrelated mailing
list, funny how these things come up at the same time), do:

Just install this: http://search.cpan.org/dist/App-Cronjob/

Then put something like this in your crontab:

   @daily cronjob -E -j josm-build -E /path/to/build.sh

cronjob(1) will consume all the output, and either print it all or
nothing, depending on the exit code of the program it's running.

If you're running a POSIX shell script you can add this to the top of
the script:

   # Exit on errors
   trap 'fail' ERR
   fail () {
       code=3D$?
       echo "Failed with exit code $code"
       exit 1
   }

Then you don't have to check the exit code of everything individually.

I use this for all my cronjobs, see
e.g. http://github.com/avar/openstreetmap-mirror for an example, it's
what I use to get E-Mails when the JOSM GitHub mirror fails, but
*only* when it fails.
