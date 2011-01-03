From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 3 Jan 2011 17:11:53 -0600
Message-ID: <20110103231153.GA10733@burratino>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
 <4D224475.1090805@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Griessen <john@ecosensory.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 00:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZtZY-0000aW-C8
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 00:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab1ACXMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 18:12:09 -0500
Received: from mail-yi0-f66.google.com ([209.85.218.66]:62353 "EHLO
	mail-yi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1ACXMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 18:12:08 -0500
Received: by yic24 with SMTP id 24so1851422yic.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NN3xZKImpmu/LYX9S+ZzAyP20XzTEK2zVxPUQY6c4V8=;
        b=AKh20H5ivQk8kqAOCVePD3Wg6D5y9giOfAmVGfDEqAeLVO/h9EGwIa85kfZh0Na5D5
         rvSwePecSw6WmjlmfpWsrDKtLHbzwfCgzLOesXzia3Prrn09wx4Va1nbeKi4yJMM+vmY
         42fwhKnA6J3cWN4TpYJgWujgCK/E6Id3BGmS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CPCRDJvKHz8PcHyNLygBw89CTItFHvS9uD0RiH796BQFaaySH6eICD7Lc/J1jBlh97
         US0TsQF4pVFYKzmqtNT3vYhk9RKQQYRPSXxxiHxucdVGN1JMOLoPmhhKNwC15F7dePGQ
         gMn54yXJY8wm6oQuUDOiSIHV/7Hqkpjpau+EY=
Received: by 10.90.2.20 with SMTP id 20mr13114330agb.69.1294096325842;
        Mon, 03 Jan 2011 15:12:05 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id 35sm28710878ano.31.2011.01.03.15.12.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 15:12:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D224475.1090805@ecosensory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164460>

Hi John,

John Griessen wrote:

> john@toolbench:~/EEProjects/test$ git clone git://ecosensory.com/tek_7k_ext.git
> Cloning into tek_7k_ext...
> fatal: protocol error: bad line length character: fata
[...]
> Next I tried changing my command that runs git-daemon
> from
> 
> exec 2>&1
> echo 'git-daemon starting.'
> exec chpst -ugitdaemon \
>   "$(git --exec-path)"/git-daemon --verbose --base-path=/var/cache /var/cache/git

Worrisome.  Based on /usr/share/doc/git-daemon-run/README.Debian,
I would be interested in:

	git --version
	dpkg -l git-daemon-run
	sv stat git-daemon
	cat /var/log/git-daemon/current

It looks like the daemon is sending a malformed reply starting with
"fatal: ", similar to the bug fixed by v1.7.0.3~7 (daemon:
parse_host_and_port SIGSEGV if port is specified, 2010-03-20).

It the error message does not provide any insight, I'd also suggest
using strace or ltrace to attach to the running git-daemon process to
see what's going on.

Thanks for reporting,
Jonathan
