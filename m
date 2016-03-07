From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH] clone: make 'git clone -c
 remote.origin.fetch=<refspec>' work
Date: Mon, 07 Mar 2016 16:19:31 +0100
Message-ID: <20160307161931.Horde.TcdEVtHKgSMvScCDUKLclVq@webmail.informatik.kit.edu>
References: <1457313062-10073-1-git-send-email-szeder@ira.uka.de>
 <xmqqfuw3rrwb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 16:20:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acwxc-0007pP-BX
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 16:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbcCGPU2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2016 10:20:28 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45922 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366AbcCGPTw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Mar 2016 10:19:52 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1acwwm-0003LL-2W; Mon, 07 Mar 2016 16:19:48 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1acwwV-0005nV-TN; Mon, 07 Mar 2016 16:19:31 +0100
Received: from x590cb2aa.dyn.telefonica.de (x590cb2aa.dyn.telefonica.de
 [89.12.178.170]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 07 Mar 2016 16:19:31 +0100
In-Reply-To: <xmqqfuw3rrwb.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1457363988.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288391>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Check whether there are any relevant configured fetch refspecs and
>> take those into account during the initial fetch, unless running 'gi=
t
>> clone --single-branch'.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> ---
>
> Even though I think the original description did not mean to include
> the fetch refspecs when it talked about configuration taking effect,
> I think what this change wants to do probably makes sense.

Well, currently one would have to clone, set additional fetch refspecs,
fetch again and repack.  Using 'git clone -c <refspecs>' would do it in
a single step, requiring fewer commands, less time, less data transfer
and less disk space, which fits the justification of v1.7.7-rc0~90^2
perfectly.

Or init, add remote, set additional refspecs and fetch, which still
requires more commands, but at least doesn't transfer more data.

>> I'm unsure what to do with the '-c <fetch-refspec> --single-branch'
>> combination: it doesn't really make sense to me and can't imagaine a
>> use case where it would be useful...  but perhaps I just lack
>> imagination on this Sunday night.  Hence the RFC.
>
> My knee-jerk reaction is to change the last paragraph of your log
> message to read more like
>
> 	Always read the fetch refspecs from the newly created config
> 	file, and use that for the initial fetching.
>
> and do so even when running with "--single-branch".

Ok, will change the '--single-branch' codepath as well.

But before doing so, to avoid a possible misunderstanding on my part:
I'm not sure how literally you meant that "from the newly created
config file" part, because it ignores refspecs specified via any
other means, e.g. 'git -c <fetch-refspec> clone'.  I think the
initial fetch should be no different from "regular" fetches, and
should respect all configured fetch refspecs regardless where they
come from.
