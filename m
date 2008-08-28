From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/3] Handle NoRemoteRepositoryException in
	PushOperation especially
Date: Wed, 27 Aug 2008 19:19:36 -0700
Message-ID: <20080828021936.GA8624@spearce.org>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com> <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYX8X-0003YW-0E
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYH1CTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYH1CTh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:19:37 -0400
Received: from george.spearce.org ([209.20.77.23]:59453 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYH1CTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:19:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 55D6138375; Thu, 28 Aug 2008 02:19:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219887370-17265-2-git-send-email-marek.zawirski@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94016>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
> index 94cf4aa..04ca28f 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/coretext.properties
> @@ -61,5 +61,6 @@ ListRemoteOperation_title=Getting remote branches information
>  PushOperation_resultCancelled=Operation was cancelled.
>  PushOperation_resultNotSupported=Can't push to {0}
>  PushOperation_resultTransportError=Transport error occured during push operation: {0}
> +PushOperation_resultNoServiceError=Push service is not available: {0}
>  PushOperation_taskNameDryRun=Trying pushing to remote repositories
>  PushOperation_taskNameNormalRun=Pushing to remote repositories
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
> index 8811800..a0f2e5c 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/PushOperation.java
> @@ -125,6 +126,10 @@ public void run(IProgressMonitor monitor) throws InvocationTargetException {
>  				final PushResult pr = transport.push(gitSubMonitor,
>  						specification.getRefUpdates(uri));
>  				operationResult.addOperationResult(uri, pr);
> +			} catch (final NoRemoteRepositoryException e) {
> +				operationResult.addOperationResult(uri, NLS.bind(
> +						CoreText.PushOperation_resultNoServiceError, e
> +								.getMessage()));

Isn't this when combined with the prior patch going to result in a message like:

	Push service is not available: git://repo.or.cz/egit.git push service is not available

which is sort of redundant and confusingly redundant, isn't it?

-- 
Shawn.
