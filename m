From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 19:46:36 +0100
Organization: gmx
Message-ID: <321a67762d18795b743b242618950849@www.dscho.org>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
 <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
 <20150123133033.GA27692@peff.net>
 <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
 <20150123183737.GA32191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:47:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjG4-0002xk-9G
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbbAWSq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:46:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:54073 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756137AbbAWSqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:46:55 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MNZ9u-1YKlfD2p9m-007Art; Fri, 23 Jan 2015 19:46:37
 +0100
In-Reply-To: <20150123183737.GA32191@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:LE6L+W0ObiJCVEWOvgo9Ym9wyHv/zg9jD1SNNZ4cd6m6MwX85R7
 oSO9/kYYWe86Fcs4d8S9s/cWTWhkfOpJx8D0gjAJltqtAaqaTy9i2+aolPLDdRo3Vm1k8Rv
 2sZQUwmC3CtAKzvWZum/TKII3UVNbAN9QIV/T038r6Unt+oMX/OhcyxYdQ0g3F2EeD8pzAu
 koly0Oz8BkwyP+3qAwdDQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262944>

Hi Peff,

On 2015-01-23 19:37, Jeff King wrote:
> On Fri, Jan 23, 2015 at 10:07:18AM -0800, Junio C Hamano wrote:
> 
> [...] one thing that puzzles me is that the current code looks
> like:
> 
>   if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> 	  severity = options->msg_severity[msg_id];
>   else {
> 	  severity = msg_id_info[msg_id].severity;
> 	  ...
>   }
> 
> So if the severity override list given by "options" exists, _and_ if we
> are in the enum range, then we use that. Otherwise, we dereference the
> global list. But wouldn't an out-of-range condition have the exact same
> problem dereferencing that global list?
> 
> IOW, should this really be:
> 
>   if (msg_id < 0 || msg_id >= FSCK_MSG_MAX)
> 	die("BUG: broken enum");
> 
>   if (options->msg_severity)
> 	severity = options->msg_severity[msg_id];
>   else
> 	severity = msg_id_info[msg_id].severity;
> 
> ? And then you can spell that first part as assert(), which I suspect
> (but did not test) may shut up clang's warnings.

To be quite honest, I assumed that Git's source code was assert()-free. But I was wrong! So I'll go with that solution; it is by far the nicest one IMHO.

Thanks!
Dscho
