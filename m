From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Mon, 15 Jun 2009 22:45:45 +0100
Message-ID: <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
	 <200906131333.57725.markus.heidelberg@web.de>
	 <200906152313.20002.markus.heidelberg@web.de>
	 <e5bfff550906151425p2dacdcdasbae09af4ce34813d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jun 15 23:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGK03-0008LL-4f
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934545AbZFOVpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760355AbZFOVpo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:45:44 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:46255 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbZFOVpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:45:43 -0400
Received: by ewy6 with SMTP id 6so5415912ewy.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nyB1Zl4J5roAlee/uq2Y1Wg8RTdSwwGdgyY6ouTa2vA=;
        b=iDp/+5FdZPiACE4Kfc8aNq4gvFkMXPP8nd7lYHenl5FI5/jCycWZN19BkNHGdfKvRN
         3AkU9lvttUlLTcIzBc84dlUWGRvWp70bIpvGabd6tz1tAQ/ItWxV1K/16XdaQFvkcRNk
         Jh/aAp1m4DVOm5IUMq2WDhdsdwtNMA1/hblAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sTOotFsmFEhVRN/Hfiaj1wGI0hQCRof6q5ESxg5ZwkZQ86bNMt6S9ydtvbjI4qdl4q
         p7AxovWb0gUD7YdIthOTMWimPYiQ0bj0s1K8vU0WPOAGj1TBVy5CFXlf9KTHlUfguk70
         pK6EgIaxYyX8v2PKHAipviiLInrJ3YnnlDmW4=
Received: by 10.216.21.211 with SMTP id r61mr2498272wer.211.1245102345205; 
	Mon, 15 Jun 2009 14:45:45 -0700 (PDT)
In-Reply-To: <e5bfff550906151425p2dacdcdasbae09af4ce34813d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121633>

On Mon, Jun 15, 2009 at 22:25, Marco Costalba<mcostalba@gmail.com> wrote:
>
> This is really strange !
>

Ok. This is a quick test that perhaps you could do.

Git::formatPatch() get the list of selected revisions already ordered
by its caller, MainImpl::ActMailFormatPatch_activated() in
mainimpl.cpp, in this function the selected items are retrieved
calling ListView::getSelectedItems() in listview.cpp

There, finally, there is the call to the native Qt function that
collects the selected rows, QItemSelectionModel::selectedRows()

The returned list is takes as is by QGit and nevere reordered or
touched, so the order of the revisions belong directly on how
QItemSelectionModel::selectedRows() returns the rows.

Now the published windows version (and also teh Linux one) is compiled
against Qt4.3.3, while you are using Qt4.4.1


I have checked in the Qt documentation and I didn't found any point
where the order of the returned rows is specified, I know in Qt4.3.3
is from the top toward the bottom of the list, but perhaps in Qt4.4.1
it has been changed.

So you could check, in ListView::getSelectedItems() how the rows are returned.
