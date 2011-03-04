From: Robert Wruck <wruck@tweerlei.de>
Subject: Re: [BUG] git cat-file does not terminate
Date: Fri, 04 Mar 2011 19:26:01 +0100
Message-ID: <4D712EB9.3080802@tweerlei.de>
References: <4D70E340.3050309@tweerlei.de> <20110304154014.GE24660@m62s10.vlinux.de> <20110304160047.GA9662@sigill.intra.peff.net> <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Peter Baumann <waste.manager@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZhd-000162-UK
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 19:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950Ab1CDS0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 13:26:05 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:51237 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960Ab1CDS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 13:26:03 -0500
Received: from [10.0.1.3] (e177251182.adsl.alicedsl.de [85.177.251.182])
	by mail.tweerlei.de (Postfix) with ESMTPSA id D08A1277B5;
	Fri,  4 Mar 2011 19:26:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7vzkpa7qmp.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hydra.tweerlei.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168456>

> By the way, does the same version of Cygwin have similar issue on the read
> side?

Here some quick results:

read(fd, buffer, 90000000)
Returns total file size for a file and 65536 (errno=0) for pipes (cat 
file | readtest). When repeating the read, the whole file is read until 
read() returns 0. No problem here on any cygwin I tested.

write(fd, buffer, 90000000)
Returns 90000000 for a file.
Returns 90000000 for redirection (writetest > outfile)
Returns 90000000 for pipes (writetest | cat > outfile) on sane cygwins 
and -1 / EAGAIN on the machine with the original problem.
