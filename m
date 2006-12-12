X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 23:25:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122316290.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612121235.09984.andyparkins@gmail.com> 
 <200612121326.24508.andyparkins@gmail.com> 
 <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <200612121538.41197.andyparkins@gmail.com> 
 <fcaeb9bf0612121346s3c82bcdbh522c17f4ae9f279b@mail.gmail.com>
 <fcaeb9bf0612121348q35549a4cof0adb85e0391b92c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:25:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <fcaeb9bf0612121348q35549a4cof0adb85e0391b92c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34152>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuG4G-0003pT-Ij for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932486AbWLLWZO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWLLWZO
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:25:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:58327 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932486AbWLLWZM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:25:12 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:25:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 12 Dec 2006 23:25:11 +0100
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Nguyen Thai Ngoc Duy wrote:

> On 12/13/06, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > Hm.. I'm no git:// expert. But is it possible doing as follow?
> > 1. git-archive <base>
> > 2. reconstruct commit, blobs and trees from the archive
> > 3. tell git server that you have one commit, you need another commit
> > (maybe heads only, i'm not sure here)
> > 4. get the pack from git server, create new commit and a diff
> 
> Ok. Stupid idea. The pack may base on objects that I don't have.

The only not-so-brilliant idea is to reconstruct the commit from the 
archive. This is not possible, as not only some author and 
committer metadata is not reconstructable, but worse: the parents' hash is 
not either. And since all these are hashed to get the commit hash, you 
lost.

However, it could work like this:

- reconstruct tree commit
- ask for a diff between a certain commit, with respect to your tree

It might even be easy to convince git-upload-pack to construct a thin pack 
containing deltas _only_ against objects which are reachable from your 
tree.

Note: this is feasible, but not necessarily sensible:

- it puts more strain on the server, which otherwise could probably reuse 
a lot of deltas, and
- it contradicts the idea of _distributed_ development (for example, you 
could not tell which HEAD commit is newer when you fetched from two 
repos).

Probably, you could add a third argument: merges are not necessarily 
_possible_ with that setup. Note that this argument applies to shallow 
clones, too!

Ciao,
Dscho
