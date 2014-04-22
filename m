From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 07:01:20 +0100
Message-ID: <20140422060120.GA10198@hashpling.org>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcTlu-0005qf-7f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbaDVGB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:01:26 -0400
Received: from avasout06.plus.net ([212.159.14.18]:38043 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaDVGBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:01:23 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id su1K1n0012iA9hg01u1LpG; Tue, 22 Apr 2014 07:01:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rp1LLUWK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=FaVzYAwi6lUA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=-qyZMjV_sPhJg8cTldoA:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1WcTlg-0002iC-IQ; Tue, 22 Apr 2014 07:01:20 +0100
Content-Disposition: inline
In-Reply-To: <20140422045951.GA60610@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246697>

On Mon, Apr 21, 2014 at 09:59:52PM -0700, David Aguilar wrote:
> [Cc:ing Charles in case he has an opinion, this behavior dates back to the original MT]
> 
> On Sun, Apr 20, 2014 at 07:17:34PM -0500, Felipe Contreras wrote:
> > It's annoying to see the prompt:
> > 
> >   Hit return to start merge resolution tool (foo):
> > 
> > Every time the user does 'git mergetool' even if the user already
> > configured 'foo' as the wanted tool.
> > 
> > Display this prompt only when the user hasn't explicitly configured a
> > tool.
> 
> I agree this is probably helpful.
> Most users I've met end up configuring mergetool.prompt=false.

>From my memory, the reason that we choose to prompt by default is to
help new users or users who have just changed their choice of mergetool.

Because we never use the exit code of the tool to determine whether a
tool "worked", if we don't prompt and the tool fails (bad custom
command, requires X when no X available, etc.) then we'll repeatedly run
the command for all paths requiring resolution leading to, potentially,
a lot of trace with whatever error the tool might happen to report.

We prompt by default to give users a chance to abort the mergetool
session at the first opportunity that they see that the configured tool
is not working.

Personally, I leave mergetool.prompt unset (default true) because one
extra click in a complex merge resolution is relatively low overhead and
to catch myself when I forget that I'm in a no-X environment.

I glanced at the patch and it seems to subvert this intent for users
who have  configured a merge tool. Is my understanding correct?
