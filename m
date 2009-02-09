From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Add the signed-off in the commit text dialog
Date: Mon, 9 Feb 2009 07:46:27 -0800
Message-ID: <20090209154627.GJ30949@spearce.org>
References: <499048FD.7050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYNE-0003dc-6f
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZBIPq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755661AbZBIPq2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:46:28 -0500
Received: from george.spearce.org ([209.20.77.23]:59123 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbZBIPq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:46:28 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5D32038210; Mon,  9 Feb 2009 15:46:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <499048FD.7050803@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109085>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> The user can see and edit the signed-off in the commit dialog
> before committing.
> 
> For new lines in the commit dialog, use Text.DELIMITER for
> plateform neutrality.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
> This patch only applies after the 2 previous patches.
> If you want to, I could probably modify this patch so that it would
> apply on the current origin.

The other two have been applied so no need to rebase.
 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> index 9d062cc..8f85c08 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> @@ -67,6 +68,8 @@
>   */
>  public class CommitDialog extends Dialog {
>  
> +	private static Pattern signedOffPattern = Pattern.compile("(.|\r|\n)*Signed-off-by: .*(\r|\n)*"); //$NON-NLS-1$

Wouldn't "[.\r\n]" be easier to use here than "(.|\r|\n)"?

> @@ -214,6 +217,30 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
>  		signedOffButton.setText(UIText.CommitDialog_AddSOB);
>  		signedOffButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
>  
> +		signedOffButton.addSelectionListener(new SelectionListener() {
> +			boolean alreadySigned = false;
> +			public void widgetSelected(SelectionEvent arg0) {
> +				if (alreadySigned)
> +					return;
> +				if (signedOffButton.getSelection()) {
> +					alreadySigned = true;

Huh.  So I can only push the checkbox once, and that after that
its just an idiot switch?

If that's really going to be how it is, maybe we should disable
the checkbox?

FWIW, git-gui actually looks for the user's Signed-off-by line in the
text buffer.  If it can't find it, then it appends it onto the end.
That way the user can delete the line and do the sign off again if
they messed up somehow.

And actually, given that this is a checkbox and not a button, maybe
we should be able to *delete* the SBO line when the user tries to
uncheck the checkbox.  Which then gets into, what if the user made
an edit to the text and changed the SBO line, should this box get
unchecked automatically by some form a listener on the text box?

Food for thought.  I'm not sure what it should be.  But if it were
a checkbox, as a user I'd like it to be bi-directional (both add
and remove my SBO) and also uncheck when I edit or delete the SBO
line in the message box.

-- 
Shawn.
