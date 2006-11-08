X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nix <nix@esperi.org.uk>
Subject: What's the meaning of `parenthood' in git commits?
Date: Wed, 08 Nov 2006 00:39:00 +0000
Message-ID: <878ximbwm3.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 00:39:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Emacs: it's like swatting a fly with a supernova.
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31104>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhbTK-0002fv-07 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 01:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751907AbWKHAjF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 19:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbWKHAjF
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 19:39:05 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:33042 "EHLO
 mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1753747AbWKHAjD (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 19:39:03 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18]) by
 mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id kA80d1oH009390
 for <git@vger.kernel.org>; Wed, 8 Nov 2006 00:39:01 GMT
Received: (from nix@localhost) by esperi.org.uk
 (8.12.11.20060614/8.12.11/Submit) id kA80d0kI008701; Wed, 8 Nov 2006 00:39:00
 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

So I'm back on the weird porcelain I mentioned months and months ago,
the one which treats source trees as named collections of patches merged
together in different ways, almost like stgit on steroids, only not.

It occurred to me recently that packed refs provide about 50% of what I
need (efficient handling of lots and lots of refs); most of the other
50% consits of a new extremely weird git merge strategy,
`git-merge-patched', which merges branches A and B by finding the most
recent merge-base between branch B and any branch listed in
.git/refs/trunks (`trunks' being a directory holding heads which are
treated this way by this weird merge strategy; the porcelain will have
to keep it up to date, which shouldn't be too terribly hard), and
patch(1)ing the diff between that base and the tip of branch B into
branch A. (A patch rejection, of course, means merge-by-hand and commit,
as usual with merge conflicts.)

The idea being that if you have a tree like this:

     B
------------- ref trunks/latest
     \
      ------ ref heads/some-change-foo

 ... -------- ref trunks/old-and-grotty


then this merge strategy, when asked to merge heads/some-change-foo into
trunks/old-and-grotty would spot that point B was the most recent
merge point into anything in trunks/, generate a diff between point B
and heads/some-change-foo, and patch it into trunks/old-and-grotty.

(I *know* this is really weird, but I've got a choice of doing this or
continuing to use SCCS with the world's most horrible shell script
wrapper as the source code repository for ~5Gb of source, with tens of
thousands of files in a flat directory structure, expanded to 50Gb
because we're storing binary files in there by the astonishingly
inefficient means of uuencoding them and sccsing the result: you may be
sick now. I know which I'd prefer. I may be distorting git into
something unrecognisable to its own father but it's that or I go insane
*and* run out of disk space.)


After all that setup, my question's simple. Does a `parent' in git
terminology simply mean `this commit was derived in some way from the
commit listed here'? If so, I suppose I can list heads/some-change-foo
as one parent on these merge commits, even though the `merging'
mechanism is so odd that I expect to be pelted with rotten vegetables as
soon as I post this.

But it's that or SCCS.

(Of course this will go into a public git repository for people to laugh
at. I don't expect anyone to actually *use* it.)

-- 
Rich industrial heritage: lifeless wasteland. `The land
