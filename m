From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: t5561 failing after make PROFILE=GEN
Date: Thu, 24 Sep 2015 02:22:10 +0200
Message-ID: <56034232.6030100@gmx.net>
References: <5601E283.2030507@gmx.net> <20150923232443.GA21755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 02:24:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeuKY-00013Y-E1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 02:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbbIXAYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 20:24:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:60110 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357AbbIXAYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 20:24:04 -0400
Received: from [192.168.178.43] ([92.76.227.98]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M5csW-1acOk50rCS-00xYib; Thu, 24 Sep 2015 02:24:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150923232443.GA21755@sigill.intra.peff.net>
X-Provags-ID: V03:K0:KDP16LW6MAuTNGhWd+dzqTVDy1MFlk3wLaGEySTZgYhlEvF9tkl
 5Z4pV7DirojYaZHOd4A/MjjXskiIa5MrfT6qnii2PTdY5G2P5tZgdHqm7llAtNMHFtjE7Xn
 jah1XSF4zWyUJR8sdlet2Y5tR/lhRQGakL71AH4woiHIxjeIMOqnLvH6oaNf1ssrmlMo9aE
 8JkYJ5e7t8jSrL9mWy5pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TCXqiipVR9s=:e1H249JFbh9DWq58vP6xUm
 rcCkTvmwymy/ONSWjkFuVcXw8Gt15bs5/JkkorVWYzGIc4cPI9feC8Mk/7rrlOb57eBafkgw7
 ieo0wMkUNdhXwibyDEuRTqARp/d2gBtNJVbHQCCEXJEKMbiOLpXU7zcv/FNHL1/oVz8hBKaAk
 AJFW3vGJW9ce2gUNwSwly9RLoc71LJqgOO61+Gn0j4JaZFFamnDMGJvLutZfNOPx6U9v3M27/
 MaHD/7/7wqCgUbZTaXfStUH3tKz1ED0x2LTMpW9SXfq8+JERIJ/6D0oRSxHuKzieSRZG585qa
 ME5Fs8W4Dms3p8epGiKhwqZgs/NjwcM3lfZxaa5858TeDUhivxYbDw2SB/JJwqY4B6GCVzDPB
 1CPuZH7Yv9DlymDhN4KRXd0rvf8ZSHIfrL/4y0rTlf4aq6MZFIX7D47T6wbpwxlGrs2fWcI8/
 2iwVuRCwl3CLXuo1qIrcuFmduKxVe/BassBP19cVpRZ8HWxEh09qhr9KSvSMfOmR4PgfMeHym
 Y9pfsNn2waecIjSZHF7tS+fcGa2n2IGPLCkFz2XpRygJl/f1f4oCTGF7h8Ut6WVvr0A2yrHM6
 sJW6RNwVAP41k34jhyW2AQL9y9M0R/GTDT2BQC8LYufFuF5veRTQwkjhJAwenL/aWQM1OPnf9
 rYKpYHpR/7Q10SGxlqzy76EPBFY1dRKraS4xCEB4AYhuzcezsmBwihKx6alJYrD7hyTQVDNNt
 YIWjgRAVbwnPlQF2PBHvj7bbV57IQ9sE9HWWIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278525>

Hi,

On 09/24/2015 01:24 AM, Jeff King wrote:
>> I noticed that t5561 fails on my machine when compiling with
>> "make PROFILE=GEN". Luckily, the reason seems to be the test only,
>> not the tool it is testing.
>>
>> I tracked it down that far that log_div() (defined in
>> t/t5561-http-backend.sh but used in t/t556x_common) appends
>> the given text to the access.log *before* the last GET log entry
>> is written.
> 
> Yes, I have run into this before. I _think_ I've also seen it once in a
> non-profile build. Which would make sense, if it is simply racy but the
> race usually goes the right way, and something about the profile build
> upsets that.

I only checked for profile builds and first tried to bisect the issue,
which went terribly wrong because using older Git commits (unluckily I
can't say now how far you should go back in history), the test failed or
succeeded randomly. So it always found different (and always unrelated)
commits using "git bisect run".
However, in the latest versions, it *always* fails for a profile build
(and *never* for a non-profile build, at least here).

Maybe this needs some more investigation?

> It's nothing in the environment; if you have a profile build and run "cd
> t && ./t5561-*", it will still fail. So it's something about the build.
> I'd guess it would be that git-http-backend is taking extra time after
> the session is over to write out the profile data, and that apache
> delays writing the log entry until it is done.
> 
> Aha. That seems to be it. If I add
> 
> diff --git a/http-backend.c b/http-backend.c
> index bac40ef..88610b4 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -699,5 +699,6 @@ int main(int argc, char **argv)
>  					   max_request_buffer);
>  
>  	cmd->imp(cmd_arg);
> +	sleep(1);
>  	return 0;
>  }
> 
> then it fails for me even without a profile build.

Hmm, but why is the profile build of http-backend "slower"? (Or am I
getting it wrong?)

> Touching the apache logfile ourselves is inherently racy.

It would not be racy if we started/stopped apache before/after each test
(and only append to the logfile after each apache shutdown). But that
would slow it down a lot.

> And this isn't anything to do with git's behavior, but just the test
> script. So I think dropping the log_div is probably our best bet. We may
> want to keep the existing "expected" file with the "###" lines as
> comments, and then simply strip them out when comparing to the actual
> output (so the test script remains readable).

That's a very good idea. (I just sent a patch with a possible realization.)

Stephan
