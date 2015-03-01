From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4 1/2] gitk: write only changed configuration variables
Date: Mon, 2 Mar 2015 10:47:30 +1100
Message-ID: <20150301234729.GB24862@iris.ozlabs.ibm.com>
References: <1415571602-5858-1-git-send-email-max@max630.net>
 <1415571602-5858-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 01:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSEIt-0007Ay-V0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 01:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbbCBAdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 19:33:42 -0500
Received: from ozlabs.org ([103.22.144.67]:46561 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbbCBAdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 19:33:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9E4A214010F; Mon,  2 Mar 2015 11:33:40 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1415571602-5858-2-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264570>

On Mon, Nov 10, 2014 at 12:20:01AM +0200, Max Kirillov wrote:
> When gitk contains some changed parameter, and there is existing
> instance of gitk where the parameter is still old, it is reverted to
> that old value when the instance exits.
> 
> Instead, store a parameter in config only it is has been modified in the
> exiting instance. Otherwise, preserve the value which currently is in
> file.  This allows editing the configuration when several instances are
> running, and don't get rollback of the modification if some other
> instance where the configuration was not edited is closed last.
> 
> For scalar variables, use trace(3tcl) to detect their change. Since `trace` can
> send bogus events, doublecheck if the value has really been changed, but once
> it is marked as changed, do not reset it back to unchanged ever, because if
> user has restored the original value, it's the decision which should be stored
> as well as modified value.
> 
> Treat view list especially: instead of rewriting the whole list, merge
> individual views. Place old and updated views at their older placed, add
> new ones to the end of list. Collect modified view explicitly, in newviewok{}
> and delview{}.
> 
> Do not merge geometry values. They are almost always changing because
> user moves and resises windows, and there is no way to find which one of
> the geometries is most desired. Just overwrite them unconditionally,
> like earlier.
> 
> Signed-off-by: Max Kirillov <max@max630.net>

Looks pretty nice; I just have one comment:

> +		lappend views_modified_names $current_viewname($v)

This view_modified_names variable doesn't seem to be used anywhere.
If you don't mind me taking out this line, I'll do that and apply the
patch.

Regards,
Paul.
