From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Tue, 21 Sep 2010 04:12:05 +0200
Message-ID: <4C981475.10404@gmail.com>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de> <4C973E5B.4090201@gmail.com>        <4C9782A3.5010005@gmail.com> <201009210015.o8L0FcJt020691@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 04:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxsLA-0004qk-W4
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 04:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab0IUCML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 22:12:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47095 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab0IUCMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 22:12:10 -0400
Received: by fxm3 with SMTP id 3so1137133fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 19:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=Ww9MbiljpkInc5h7M7+RAQ2y3UCdr1OxllH+QJP15Q8=;
        b=CNcqQhKOGK7tuyeaT91AZLR1Ra+bTNO+3VL9KCTwtqinO2YsfQJGepnCe4J60olRQD
         vPimquW4YEfbmLzodr9lyLeijs+U8ymzofU1xX9OrcYkUlvYIXAb2USyyyI1+/gY09TT
         gY5AZWAWlpP/pl8Hx9KxPTkEsKQeDYdn7WBSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=dtg1cW4pmBzcv5JHj2Vf5pg6eFBzr0gMnCYlKWCV0G3x1Lf6HAjroFpToCP37KRRFd
         PNnm3chFA7WQSxpGVzrwKxWc+wP/bK0zEeoyS0OQHJLLY5PSg1nfcNFh0VgqeKmttLYI
         H6Le0gppSSzIQ1/zyXPKoHb4dYrH2R2Wunej4=
Received: by 10.223.126.82 with SMTP id b18mr5437490fas.38.1285035128729;
        Mon, 20 Sep 2010 19:12:08 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-127-143.multimo.pl [89.174.127.143])
        by mx.google.com with ESMTPS id h12sm3327751faa.13.2010.09.20.19.12.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 19:12:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <201009210015.o8L0FcJt020691@no.baka.org>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156687>

On 09/21/10 02:15, Seth Robertson wrote:
> 
> I've discovered an error case in your pike script's logic (as and if I
> understand it).  If there are multiple children of the commit in
> question and those two children both merge onto the target branch, the
> path your program prints is incorrect (specifically, for reference B
> it prints D and then G--the correct answer is G only or a least D+H).
> It does not check to see whether a specific reachable merge commit is
> reachable by the path you have started to print.
> 
> ----master-----------G------H
>                     /      /
>                     |     /
>  --A-------D-----------F-
>           /         |
>  ----B---C          |
>       \             |
>        ----------E--/

I haven't checked, but I expect it to print exactly 'D' and 'G'.
'H' isn't interesting, as both parents already contain 'B'.
Yes, 'D' could be omitted, but knowing where else 'B' also
appeared /can/ be useful (and figuring out if it's safe to skip
'D' would be more expensive).

>     Unpikifying is left as an exercise for the user. ;)
> 
> I've converted it to perl and it now handles both your problem (which

I wasn't exactly thinking of perl when i wrote that... :)

> Of course it still suffers from reporting branches created after the
> reference you are interested in was created.

Well, at least git-find-branch-for, shows (some) merges _to_ other
(topic/remote) branches, but after browsing the kernel history
for a while i'm a bit surprised -- this causes significantly less
problems than i expected.

I haven't looked at your script, so i'm not sure what exactly it
tries to do, but i ran a quick test, using the kernel tree:

$ time git-find-branch-for 1f9c381fa3e0b9b9042e310c69df87eaf9b46ea4 
84e48b6d64fd Merge of master.kernel.org:/home/rmk/linux-2.6-rmk.git   050503 22:27
bfd4bda097f8 Merge with master.kernel.org:/pub/scm/linux/kernel/git/t 050505 12:59
325a479c4c11 Merge with temp tree to get David's gdb inferior calls p 050517 22:53
ad34ea2cc384 merge by hand - fix up rejections in Documentation/DocBo 050520 20:27
0m10.549s user   0m0.713s system   0m10.963s elapsed   102.74% CPU
$
$ time git-what-branch 1f9c381fa3e0b9b9042e310c69df87eaf9b46ea4 
1f9c381fa3e0b9b9042e310c69df87eaf9b46ea4 first merged onto v2.6.32.n using the following minimal path:
  v2.6.12-rc3-450-g1f9c381 merged up at v2.6.12-rc4-39-gad34ea2 (Fri May 20 22:27:44 2005)
  v2.6.12-rc4-39-gad34ea2 merged up at v2.6.12-rc3-590-gbfd4bda (Thu May  5 14:59:37 2005)
  v2.6.12-rc3-590-gbfd4bda merged up at v2.6.12-rc3-461-g84e48b6 (Wed May  4 00:27:24 2005)
  v2.6.12-rc3-461-g84e48b6 is on v2.6.32.n
18m29.771s user   0m29.681s system   18m4.897s elapsed   105.03% CPU
$

Results are similar, that one extra merge i'll have to take a look at
later, but the cost difference...

artur
