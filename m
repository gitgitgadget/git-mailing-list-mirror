From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 3/9] http-fetch: Abort requests for objects which arrived in packs
Date: Wed, 1 Feb 2006 09:12:25 -0800
Message-ID: <20060201171225.GI3873@reactrix.com>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk> <20060201114430.5042.5144.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 18:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4LXB-000244-9B
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 18:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWBARMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWBARMm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 12:12:42 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:16901 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030375AbWBARMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 12:12:41 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k11HCP9D024973;
	Wed, 1 Feb 2006 09:12:25 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k11HCPK1024971;
	Wed, 1 Feb 2006 09:12:25 -0800
To: Mark Wooding <mdw@distorted.org.uk>
Content-Disposition: inline
In-Reply-To: <20060201114430.5042.5144.stgit@metalzone.distorted.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15428>

On Wed, Feb 01, 2006 at 11:44:31AM +0000, Mark Wooding wrote:

> +void release_active_slot(struct active_request_slot *slot)
> +{
> +	closedown_active_slot(slot);
> +	if (slot->curl) {
> +		curl_multi_remove_handle(curlm, slot->curl);
> +		curl_easy_cleanup(slot->curl);
> +		slot->curl = NULL;
> +	}
> +	fill_active_slots();
> +}

Does it make sense to call curl_easy_cleanup here?  This will close
persistent server connections and cause another connection startup if
the slot is reused.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
