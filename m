From: "Jacobs, Todd" <todd.jacobs@cognex.com>
Subject: Pull and fetch don't honor `--progress` flag
Date: Wed, 16 Oct 2013 15:50:51 -0400
Message-ID: <48AC4CE6F0887542B2A5E28E4E7A929740FA5349A9@Viper-RSG.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 16 22:00:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWXGs-00027v-66
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 22:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761353Ab3JPUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 16:00:38 -0400
Received: from mx2.cognex.com ([198.232.29.14]:10391 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760843Ab3JPUAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 16:00:37 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2013 16:00:37 EDT
X-Host-mx2: True
X-IronPort-AV: E=Sophos;i="4.93,508,1378872000"; 
   d="scan'208";a="6676296"
Received: from cook.cognex.com ([10.10.128.31])
  by mx2.cognex.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Oct 2013 15:50:53 -0400
Received: from BMUS3.pc.cognex.com (bmus3.pc.cognex.com [10.3.160.239])
	by cook.cognex.com (8.14.3/8.14.3) with ESMTP id r9GJor9b027520
	for <git@vger.kernel.org>; Wed, 16 Oct 2013 15:50:53 -0400 (EDT)
Received: from Viper-RSG.pc.cognex.com ([::1]) by BMUS3.pc.cognex.com ([::1])
 with mapi; Wed, 16 Oct 2013 15:50:53 -0400
Thread-Topic: Pull and fetch don't honor `--progress` flag
Thread-Index: Ac7Kp6bmImZiHpDaS+ufIBUIe9VyGg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236257>

When I use the `--progress` flag with the push command, I get transfer-speed statistics like this:

    $ git push -progress origin master 2>&1 | tee /tmp/push
    Counting objects: 30, done.
    Compressing objects: 100% (20/20), done.
    Writing objects: 100% (30/30), 9.02 MiB | 206.00 KiB/s, done.
    Total 30 (delta 0), reused 0 (delta 0)

This also works similarly with clone:

    $ git clone --progress "$url" foo.git 2>&1 | tee /tmp/clone
    Cloning into 'foo.git'...
    remote: Counting objects: 61, done.
    remote: Compressing objects: 100% (43/43), done.
    remote: Total 61 (delta 3), reused 0 (delta 0)
    Receiving objects: 100% (61/61), 15.22 MiB | 473.00 KiB/s, done.
    Resolving deltas: 100% (3/3), done.
    Checking connectivity... done

However, even though pull and fetch also have the same flag documented, git never reports any network statistics at all. For example:

    $ git pull --progress origin master 2>&1 | tee /tmp/pull
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 3 (delta 1), reused 0 (delta 0)

This is repeatable with both Git 1.7.9 and Git 1.8.4.1 running under Cygwin. Is this a bug? If not, how can I make fetch and pull cough up throughput statistics?
