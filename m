From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Teach "delta" attribute to pack-objects.
Date: Tue, 22 May 2007 12:04:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705221200010.3366@xanadu.home>
References: <11795608912129-git-send-email-junkio@cox.net>
 <11795608922961-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 18:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqWrO-0002wQ-JA
	for gcvg-git@gmane.org; Tue, 22 May 2007 18:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764800AbXEVQFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 12:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763990AbXEVQFE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 12:05:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51849 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764800AbXEVQFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 12:05:01 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIG000S9A0B4E50@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 May 2007 12:04:59 -0400 (EDT)
In-reply-to: <11795608922961-git-send-email-junkio@cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48109>

On Sat, 19 May 2007, Junio C Hamano wrote:

> This teaches pack-objects to use .gitattributes mechanism so
> that the user can specify certain blobs are not worth spending
> CPU cycles to attempt deltification.
[...]
> @@ -1349,6 +1376,10 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>  
>  		if (entry->size < 50)
>  			continue;
> +
> +		if (entry->no_try_delta)
> +			continue;
> +
>  		free_delta_index(n->index);
>  		n->index = NULL;
>  		free(n->data);
> @@ -1376,6 +1407,8 @@ static void find_deltas(struct object_entry **list, int window, int depth)
>  			m = array + other_idx;
>  			if (!m->entry)
>  				break;
> +			if (m->entry->no_try_delta)
> +				continue;
>  			if (try_delta(n, m, max_depth) < 0)
>  				break;
>  		}

This last hunk is unnecessary.  Because of the other hunk above, the 
no_try_delta objects will never get into the m array.

Well done otherwise.  This attribute thing is really nice.


Nicolas
