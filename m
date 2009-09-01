From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT] potential incompatibility with old git repos.
Date: Tue, 1 Sep 2009 21:07:56 +0000 (GMT)
Message-ID: <723287.10285.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Spearce <spearce@spearce.org>, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Tue Sep 01 23:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miagf-00036v-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 23:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbZIAVOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbZIAVOg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 17:14:36 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:26989 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752302AbZIAVOf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 17:14:35 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2009 17:14:35 EDT
Received: (qmail 10779 invoked by uid 60001); 1 Sep 2009 21:07:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1251839276; bh=gRis+JI2DvbuelBp8+ggRGQEZ22a1doLALIHJWM0kS4=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type; b=oc8OqEoxBIwTJU+x2cLs8Ra0LsX+eAh7NR9vOa9+afPQUHmRcqrxQRV4O5+nMy/slc1RNn+9svtTVt8ggcdNrUAkTyzaWOm5Ts3tG8Uowlapzspx47otK2W80b6VgPDT0DWV5lXmulPfF+rRT0AN7GaTgzMQp91vcUeTvavbr3M=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type;
  b=11JMKUCfxa1U/ZBYhAp5mnm07N/dv1RqiZnYXHnN7Ar1jczvZXJ3/CLuQcC5QIARKUv+Fk7Skc91nXp58a+eYFbBVhvOeioLlKE23wf+wLWs7pHZAlXfMeMZeB7Om4yhoruodn9e1Kg4/W/liVHLKwhrTAceZ4LmfMkkRu5opYc=;
X-YMail-OSG: xt89WMIVM1n3vENgBuqSpyDyt27KogOtJ3_COsg41p7_KsOj8vOg4.izgCbQUjqhxavWsTQa9auu56fS7cRxybTGzlJ32qQyP2MHtqcIM9QxLNChqQ3uCrL2mbcFRPTJitEPfnPZ5BgzhlQxF_DGf9sZHdaLsB_vmlgbRq7uj4kt4gfqLtppDAPICS_POVBrF58_vd0kEl1vNVLGQprHkrHVqyDMIwuJ64gYpDQE0l.9ZjzJpyCkhPQcFocheXoLvLEa.kWs.5mBGLKfws1cahr1LUGHrJSI_MJhxvjegT6ze.XyCSsqKeoW
Received: from [62.47.156.223] by web27802.mail.ukl.yahoo.com via HTTP; Tue, 01 Sep 2009 21:07:56 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127557>

Hi Shawn, Robin!

I'm happy to spend some time on the maven-scm-providers-jgit again, but spotted a problem with running the latest version of JGIT on my test repository [1]. This test repo has been created a good while ago (~nov 2007) with git 1.3.54 or so and has been edited on various computers.

It works with native git but crashes with both SimpleRepository#clone [2] and jgit.

jgit fails with "cannot checkout; no HEAD advertised by remote"
in guessHEAD

JGIT used to work on this repo until a few weeks. I tracked it down with git bisect and found commit
72b1f0d334729a49cc52e4762093148be62bea39
to be the bad one.

I glimpsed at the code and it appears that the new code in RefDatabase#readLine is not Windows CR+LF aware. (This hits me although I use Linux because our SVN at apache.org seems to have it stored with CR+LF.)

Patch will follow.

txs and LieGrue,
strub


[1] http://github.com/struberg/maven-scm-providers-git/tree/a66e9470ea087030bb8bd40edb2cab22a2de0e6a/maven-scm-provider-gittest/src/main/resources/repository/test-repo
[2] http://github.com/sonatype/JGit/tree/struberg


      
