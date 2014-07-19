From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 08/19] rebase -i: Root commits are replayed with
 an unnecessary option
Date: Sat, 19 Jul 2014 20:14:43 +0200
Message-ID: <53CAB593.5040306@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com>	<xmqqzjgj7a88.fsf@gitster.dls.corp.google.com>	<53C8E5E8.4090509@gmail.com> <xmqq7g3aobib.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8ZA9-00061Z-SM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 20:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbaGSSOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 14:14:48 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34652 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbaGSSOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 14:14:47 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so2244880wib.8
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eDOWWlv1PXTzJ+atjv01QMoNsRZnqB9AvfiP7tm2DGM=;
        b=rs+OAVr1NJD2MwgcTx5KZXunswF4dBi2ykhDQo2RSDt5z9g0loUdZ5dSSHKPUfDOBY
         Zbp08KfB82KxDFDUFtCa5Yz4POjxFs91uTsl0rrZ/aqYerj+Gf9RNhvCXl8bJgJn2jUG
         6w/+CWs2ZQ6eAWNuDyeDY/jx1KZwitKl1XbW3dOZ17PTPF8yEevW9uUMnJE+rSJetHRS
         CMvu7lA1oTqI/sE/TNqXW9Z2Ikqg7zlm/mwIio2JgBQ1tz53FMgSTc5OCzOvEIel621a
         8oq+V4zpkYQA6ylM481SM2oFY5FX1O717UKSQUKdynX4OXKDQ0pFchmuYFsZQ5S76BZx
         m25Q==
X-Received: by 10.180.91.225 with SMTP id ch1mr43803511wib.34.1405793686296;
        Sat, 19 Jul 2014 11:14:46 -0700 (PDT)
Received: from client.googlemail.com (12.196.165.83.dynamic.mundo-r.com. [83.165.196.12])
        by mx.google.com with ESMTPSA id fc7sm23534888wjc.37.2014.07.19.11.14.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 11:14:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq7g3aobib.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253903>

Hi Junio,

Junio C Hamano writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> It makes the next patch easier to understand because the finalising
>> command line "git commit --allow-empty --amend --no-post-rewrite -n
>> --no-edit" seems to be simply moved to the end of do_pick. Substituting
>> --no-edit for -C there would make that log message overly long ...
> 
> And the reason why the same "-C $1" is not used and "--no-edit" is used
> in the final version that is moved to the end of do_pick is...?

The finalising command line is executed by do_pick to rewrite $1 when it
is being replayed.

For instance, one purpose of rewriting is amending the current head with
the changes introduced by $1. In this case, we don't want the log
message of $1 to be the final log message. Another purpose of rewriting
is using a text file or a string as log message, which would be defeated
by "-C $1" as well.

It's true that, by the time the next patch is introduced, do_pick
doesn't yet implement either rewriting mechanism (they are both used to
thread "squash" through do_pick later on) but these considerations
suggest that "-C $1" might not be what we want to use to disable the log
message editor.

   Fabian
