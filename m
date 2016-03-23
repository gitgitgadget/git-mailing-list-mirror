From: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
Subject: AW: AW: git and concurrent access to local repository
Date: Wed, 23 Mar 2016 07:08:22 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF82B53CF604@TUT-EX02-PV.KSTG.corp>
References: <8C0042D8869AEA4AA334B49AFBBCEF82B53CF505@TUT-EX02-PV.KSTG.corp>
 <56F11467.3010004@web.de>
 <8C0042D8869AEA4AA334B49AFBBCEF82B53CF564@TUT-EX02-PV.KSTG.corp>
 <56F14E7F.3010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 08:08:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aicu6-0007xQ-VA
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 08:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbcCWHI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 03:08:26 -0400
Received: from mx0.karlstorz.com ([62.134.46.134]:11172 "EHLO
	mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbcCWHIZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 03:08:25 -0400
X-IronPort-AV: E=Sophos;i="5.24,381,1454972400"; 
   d="scan'208";a="24470464"
Received: from tut-ex03-pv.kstg.corp ([10.0.10.233])
  by mx0.karlstorz.com with ESMTP; 23 Mar 2016 08:08:22 +0100
Received: from TUT-EX02-PV.KSTG.corp ([169.254.2.132]) by
 TUT-EX03-PV.KSTG.corp ([10.0.10.233]) with mapi id 14.03.0266.001; Wed, 23
 Mar 2016 08:08:23 +0100
Thread-Topic: AW: git and concurrent access to local repository
Thread-Index: AdGEEMCWaucNZLm3Qs67LnHJXT7YGAABoqKAAAIdBtAABosUgAAmE0VQ
In-Reply-To: <56F14E7F.3010801@web.de>
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.60.52]
x-kse-serverinfo: TUT-EX03-PV.KSTG.corp, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/23/2016 4:35:00 AM
x-kse-attachment-filter-scan-result: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289596>

Hi Torsten,

yes, indeed I accidently pressed the wrong reply button.

The solution I'm using is the following:

pushd workingcopy > /dev/null
	(
		flock -x 200
		git reset --hard
		git clean -xfd
		git pull --rebase
	) 200>.git/gitrebase.lock
popd > /dev/null

Best Regards
Heiko

-----Urspr=FCngliche Nachricht-----
Von: Torsten B=F6gershausen [mailto:tboegi@web.de]=20
Gesendet: Dienstag, 22. M=E4rz 2016 14:54
An: Boettger, Heiko
Betreff: Re: AW: git and concurrent access to local repository

Thanks for the reply,
you may want to send it to all, including the git mailing list.
These kindof problems arise from time to time, and it may be nice to sh=
are your knowledge as well, including work-arounds


On 2016-03-22 10.54, Boettger, Heiko wrote:
> Thanks Torsten,
>
> for sharing your knowledge. That exactly what I thought. As a solutio=
n, I'm guarding the calls with "flock -x", which perfectly works since =
I know exactly where the repos are used.=20
>
> Regards
> Heiko
