From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] pack-objects: use ALLOC_GROW in place of manual growth
Date: Fri, 8 Oct 2010 11:45:36 -0500
Message-ID: <20101008164536.GB9212@burratino>
References: <20101008005256.GA21738@headley>
 <20101008074320.GB4671@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 18:48:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4G7p-0002z6-SS
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 18:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab0JHQss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 12:48:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40331 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab0JHQsr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 12:48:47 -0400
Received: by ewy23 with SMTP id 23so727504ewy.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=W8dTTJ4qjK4wX4QScAAX9lulHjA2r89Ozd4+agABxbg=;
        b=txDmIeUxaVvTm26/M85WAAjm+uHAE52mBvtht5OrMXphLXIu3QDTDqUcjoDiQp1NRg
         jtMITaaEevQceYPauLw623YQZKytmeFXmgCcYofY8IoPYtQciQwYTMeZe4yLi4RXNEdq
         3DaZ7/HEvGXKEuIvBY3fAiHo6675xbHvlnGI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j5+SGrdcJo8Jk3glReCnrQPXzvm7gCWSqMvxEPmRoYSuTvo+xLlaKFGdd+G6da3sYd
         MFEI1mmP3AS9L6I0WQ5//OZT7rqPti8lH6odVjeH2NAGjefyFPSrINNY4lVHz6eLeNIs
         omt1JNA+aeS5lEpxLj89A2Bj7xrk5HXOXfOD0=
Received: by 10.213.21.148 with SMTP id j20mr87760ebb.77.1286556526318;
        Fri, 08 Oct 2010 09:48:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e16sm481319vcm.32.2010.10.08.09.48.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 09:48:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101008074320.GB4671@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158503>

Jonathan Nieder wrote:

> -	done_pbase_paths_num++;
> +	ALLOC_GROW(done_pbase_paths,
> +		   ++done_pbase_paths_num,
> +		   done_pbase_paths_alloc);

Junio noticed that this makes done_pbase_paths_num grow by 3
rather than by 1 as intended.  Sorry.

Patch 1 corrects some documentation that could lead one
astray.  Patch 2 is a corrected patch that uses ALLOC_GROW
correctly (I hope).

Jonathan Nieder (2):
  Documentation: No argument of ALLOC_GROW cannot have side-effects
  pack-objects: use ALLOC_GROW

 builtin/pack-objects.c |   15 ++++-----------
 cache.h                |    2 +-
 2 files changed, 5 insertions(+), 12 deletions(-)

-- 
1.7.2.3
