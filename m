From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] rebase -i: avoid 'git reset' when possible
Date: Tue, 03 Mar 2009 12:19:44 +0100
Message-ID: <49AD1250.4080708@viscovery.net>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com> <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302> <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com> <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302> <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302> <7vvdqt8wob.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de> <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903031008580.6399@intel-tinevez-2-302> <alpine.DEB.1.00.0903031024420.6399@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeSgf-0008FK-Og
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbZCCLT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbZCCLT5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:19:57 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55284 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757647AbZCCLT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:19:56 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeSf3-0005Nz-6z; Tue, 03 Mar 2009 12:19:45 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C37936B7; Tue,  3 Mar 2009 12:19:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0903031024420.6399@intel-tinevez-2-302>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112054>

Johannes Schindelin schrieb:
> +# skip picking commits whose parents are unchanged
> +skip_unnecessary_picks () {
> +	fd=3
> +	while read command sha1 rest
> +	do
> +		# fd=3 means we skip the command
> +		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
> +		3,pick,"$ONTO"*|t,p,"$ONTO"*)

s/t,/3,/

> +			# pick a commit whose parent is current $ONTO -> skip
> +			ONTO=$sha1
> +			;;
> +		3,#*|3,,*)
> +			# copy comments
> +			;;
> +		*)
> +			fd=1
> +			;;
> +		esac
> +		echo "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
> +	done < "$TODO" > "$TODO.new" 3>> "$DONE" &&
> +	mv -f "$TODO".new "$TODO" ||
> +	die "Could not skip unnecessary pick commands"
> +}

-- Hannes
