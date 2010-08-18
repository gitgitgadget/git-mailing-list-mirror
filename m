From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Tue, 17 Aug 2010 21:29:31 -0500
Message-ID: <20100818022931.GA19868@burratino>
References: <20100817065147.GA18293@burratino>
 <20100817065459.GC22057@burratino>
 <AANLkTi=1Fz_wdf-grxFB17zUXpW+d26MudbbJP5K=fO_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 04:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlYR3-0002H8-Cg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 04:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746Ab0HRCbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 22:31:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34196 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab0HRCbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 22:31:10 -0400
Received: by qyk9 with SMTP id 9so499887qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iwMlD5ng9Tr10A0E8uU3W5zFPpmoTQwqVYGbFRmc0NY=;
        b=bwpoj9K4gPV1G3JV6vht8quWdnP3cUzR15slXSdfkU7IOwrfjDTa4o1QlMXf5njomG
         cqXhH62gNMaebScOrZg1No+nQYIXYNTBwHbvJLv+xz6TG/ZWbfeXmtbzTelQduIAHtaG
         /SDS/yGGN4Uh9CP+kY+mFpJDMmvNHLoq7j+Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ivZWob9vRhd+klp/tSSI8Dhf8DCeRMqm5Ky0yWnQPPvlbXROrTwYlyFHwUUaLleY6q
         CiyuRJmDhQHLAqTIGTiTc6MJhSCTINx2EcmZE5B8Uonhx72TuNsWqMUNKmggVF7opsqQ
         NGNLM6pjFiGsgUYucx2QtcucanX9sDwvZQKN0=
Received: by 10.224.29.16 with SMTP id o16mr4949250qac.155.1282098669358;
        Tue, 17 Aug 2010 19:31:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t18sm9612117qco.8.2010.08.17.19.31.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 19:31:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=1Fz_wdf-grxFB17zUXpW+d26MudbbJP5K=fO_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153803>

Sverre Rabbelier wrote:
> On Tue, Aug 17, 2010 at 01:54, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> -test_debug 'gitk --all'
>> +test_debug 'git log --graph --decorate --oneline --all'
>
>> -test_debug 'gitk --all'
>> +test_debug 'git log --graph --decorate --oneline --all'
[...]
> Really? Why can't you stuff the command to execute in a variable? On
> that note, why wasn't that done in the first place?! This kind of
> repetition is not very DRY.

My thought was that

 test_debug '$debug_command'
 ...
 test_debug '$debug_command'
 ...
 [etc]

is not very DRY either, so I am hoping some configurable version of

-- 8< --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e8f21d5..65b0e35 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -373,6 +373,7 @@ test_run_ () {
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
+	test_debug "git log --graph --decorate --oneline --all"
 	return 0
 }
 
-- >8 --

appears to replace it.  In the short term, the "s/gitk --all/git log
--graph --decorate --oneline --all/" was just meant as a quick fix
so as not to drop the feature.  Ideas?
