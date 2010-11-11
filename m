From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Thu, 11 Nov 2010 13:00:53 -0600
Message-ID: <20101111190053.GH16972@burratino>
References: <4CDB3063.5010801@web.de>
 <4CDB30D6.5040302@web.de>
 <20101111000216.GA14189@burratino>
 <4CDBA5FD.20802@web.de>
 <20101111082748.GA15525@burratino>
 <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:01:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcOl-0000Qm-Vj
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0KKTBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:01:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40731 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0KKTBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:01:17 -0500
Received: by vws13 with SMTP id 13so527219vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 11:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2vnKbX4dVJbW+H+cK2TKZzzb3LBeFfOCMh4KpVuE5X8=;
        b=Hb2pzZQvrkl33A0o8yUZKpdx9j4dttV/+8ybuK9Br+EYZ1/1VmYrGp9zgiNhufeEAO
         9kIviXAo/shnynYjOJvwLrGKGyu9AT39CyahC15u6bj0NQri7IK0QHJrmOHfip0h4z0p
         IwxpPtIb0pnzZ0/O96d8+EVT6FeY/4kmWkCKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n+oMknzgJRMWkgwylxv4wiZkRQZ8U7AFbTdDWikhsehp00qVq9726oPU8spT8Hq1Kc
         ichG+1dB70JYTnuvNJRU8iQRvA+VJA/6iMyQiOv0dXBMKPRR/WAcUsOvHnBelpTR7SmT
         +HLeHM8YAkrJ7Y6GLdSHHpsfwbv8jvxJlD+Oo=
Received: by 10.220.180.66 with SMTP id bt2mr267060vcb.134.1289502076855;
        Thu, 11 Nov 2010 11:01:16 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j21sm672052vcr.10.2010.11.11.11.01.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 11:01:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161291>

Junio C Hamano wrote:

> I think the motivation behind having a way to read it from .gitmodules is
> so that project can suggest the default for convenience (e.g. "almost
> everybody who interacts with this project wants these submodules checked
> out and kept updated").

Yes, that makes some sense to me.  Except wouldn't it be a single
configuration item?  "These submodules should be checked out in all
but unusual situations, so check them out automatically and keep them
updated."

Maybe a person setting this to false actually means "This submodule
has its url set to a repository that is updated very frequently, and
most updates are not relevant to the superproject."  Unfortunately, I
think the result would be a poor user experience: when an update comes
that _is_ important to the superproject, what happens?

 $ git fetch
 ... go on plane ...
 $ git merge @{u} && git submodule update --no-fetch --recursive
 [...]
 fatal: reference is not a tree: f1c596a3895643d0969a15b8e945bf0c0072e470

Hmm.  I think in that scenario a better solution would be to point the
submodule url point to a project-specific clone that is updated less
frequently.

What am I missing?

Jonathan
