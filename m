From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] pull: handle =?UTF-8?Q?--log=3D=3Cn=3E?=
Date: Tue, 19 May 2015 15:35:05 +0200
Organization: gmx
Message-ID: <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
 <5661061272076a1883cfde1087be4a42@www.dscho.org>
 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 15:35:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuhfz-00066B-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 15:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755500AbbESNfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 09:35:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:64730 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754482AbbESNfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 09:35:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYbFe-1YgySG45Mg-00VNGH; Tue, 19 May 2015 15:35:07
 +0200
In-Reply-To: <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2UuzZdmzYSzdI/WHCcoA+Ir80yQbAnB2YVrV84nLZs8rE4+sOrF
 RQYZC1YvsZ0zK5ktCluiQGxieDWZsqhkezzrovwLyw2pqPlBWeX2tFP15VgYbUdtwl/Az7+
 6E9NfALBoKe8lkrRY2K7QBoGFQsi+/MaLYMaTGTxPB3pory7SCAM7G2oIy3wrRIm7hX7WMq
 sh0Gxa170/f7K/rZnknAQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269354>

Hi Junio,

On 2015-05-18 20:18, Junio C Hamano wrote:

> I have been in love-hate relation with test_commit for a long time.
> It is very nice that it gives us ticks (i.e. reproducible object
> names) automatically and reduces the chance for new tests to forget
> to do so, but I found it extremely annoying that it wants to always
> add a light-weight tag to every commit it creates.
> 
> I suspect that this design decision largely comes from the fact that
> back then we did not exactly trust the syntax like "master~3" and
> wanted to have a set of fixed points, but often these auto-generated
> tags get in the way by either contaminating the refs namespaces (and
> we are testing pull here, which worries me that test authors need to
> be aware that these tags may be transferred to the destination) or
> anchoring the objects in the object database (e.g. when writing
> "reset --hard branch branch~3 && prune" tests, you need to remember
> to kill these tags).
> 
> So I dunno.  I really wish test_commit didn't create tags and either
> left the tagging to the calling script.

Yeah, light-weight tags with `test_commit` can be very annoying. IIRC the reason was not because we did not trust master~3, but that it is really unreadable. You have to be a Git nerd to find those tests intuitive that refer to master~3 which later is master~17 and then after a `git reset HEAD~5^2~3` is master~1 instead. The idea was that you could refer to the commits in question by their commit message.

I guess that I should clean up this mess and remove the tagging facility. We could use the :/<subject prefix> syntax instead, for example.

Or maybe just add a --tag flag to `test_commit` and use that in all cases where the tags were actually needed. Yeah, I think I like that option best.

Ciao,
Dscho
