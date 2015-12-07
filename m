From: Daniel Koverman <dkoverman@predictiveTechnologies.com>
Subject: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 7 Dec 2015 21:02:22 +0000
Message-ID: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a62vU-0001OH-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124AbbLGVCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 16:02:24 -0500
Received: from barracuda10.predictivetechnologies.com ([208.254.18.230]:37042
	"EHLO barracuda10.predictivetechnologies.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932813AbbLGVCY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 16:02:24 -0500
Received: from pps.filterd (ProofpointMaster.arlington.predictivetechnologies.com [127.0.0.1])
	by ProofpointMaster.arlington.predictivetechnologies.com (8.15.0.59/8.15.0.59) with SMTP id tB7KwWwP030748
	for <git@vger.kernel.org>; Mon, 7 Dec 2015 16:02:23 -0500
Received: from mail.predictivetechnologies.com ([192.168.70.11])
	by ProofpointMaster.arlington.predictivetechnologies.com with ESMTP id 1yksucjjph-1
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 07 Dec 2015 16:02:23 -0500
Received: from EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.10) by EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com
 (192.168.70.17) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Mon, 7 Dec
 2015 16:02:22 -0500
Received: from EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::5dc4:68de:a3ba:b43c]) by
 EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com
 ([fe80::5dc4:68de:a3ba:b43c%31]) with mapi id 15.00.1044.021; Mon, 7 Dec 2015
 16:02:22 -0500
Thread-Topic: Why does send-pack call pack-objects for all remote refs?
Thread-Index: AdExMorqL3V8CMb5RwSZLGZxKodLug==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.1.196]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2015-12-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 kscore.is_bulkscore=0
 kscore.compositescore=1 compositescore=0.9 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 kscore.is_spamscore=0 rbsscore=0.9 spamscore=0
 urlsuspectscore=0.9 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1507310000 definitions=main-1512070333
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282125>

I have a repository which has ~2000 branches on the remote, and it take=
s ~8 seconds to push a change to one ref. The majority of this time is =
spent in pack-object. I wrote a hack so that only the ref being updated=
 would be packed (the normal behavior is to pack for every ref on the r=
emote). =A0The push time dropped to <1 second with (seemingly) no conse=
quences. This raised a couple of questions:

1) Are there consequences for not packing refs that are not being updat=
ed? Can all operations in send-pack which operate on other refs be skip=
ped?
2) Why isn't git more selective about what it packs? Is it simply a per=
formance optimization not worth the implementation complexity?
3) Is something about my repository strange? ex: 2000 is too many branc=
hes, packing for each ref takes me an unusually long time, etc.

Thanks in advance to anyone who takes the time to clarify this for me.

Daniel
