From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Tue, 27 Oct 2009 19:16:20 -0400
Message-ID: <32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2vHW-0000dc-9M
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 00:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbZJ0XQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 19:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbZJ0XQg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 19:16:36 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:57105 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbZJ0XQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 19:16:35 -0400
Received: by gxk4 with SMTP id 4so279456gxk.8
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=UUNamuaZ08GaiA1WmbA8FpnUjEdDIpHFQIHr7sn7P24=;
        b=Mt0z4TQZoG05OsQ9+MezchJUufJzckgC1X6Jp+PrhZ41gquQVKqHNDRESrj61tA/HB
         vcL1drw4dDkoBQ9Ir7yi0PfuUOy77YriPY2vsfO4pBIEyIv7Gahz8hseCklClniFaBbf
         09j5GtPOUICqdQwN202w1fmfavPn7qfO9f9xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=v5VyGcM8de8eXK4x4tXf7iHABmet1wpUa9u3agIXO8m4tgAxcIbxJpdxn/7usp1uhJ
         VUPHw/EBepGUFJ94A6CLXeReULX3gKvtFp05VGXPjUTzvthMpbj5ENo+jXWa7z9owaJK
         GvBVix77TYlXQb4axmDfEhsErqr9NdpoCq2HE=
Received: by 10.150.20.1 with SMTP id 1mr5891902ybt.4.1256685400088; Tue, 27 
	Oct 2009 16:16:40 -0700 (PDT)
In-Reply-To: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131388>

On Tue, Oct 27, 2009 at 7:00 PM, Lachlan Deck <lachlan.deck@gmail.com> wrote:
> I'm wondering if it's possible to create a branch (starting as local but
> later on pushed to svn) that essentially stays in sync with the main branch
> (svn trunk) but both (a) ignores pulling in certain paths from trunk and (b)
> provides a few extra paths of its own (some of which overlap with those
> ignored from trunk) and (c) only pushes to trunk paths that are relevant for
> trunk (i.e., not specifically ignored)?
>
> If someone's able to share how they'd go about setting this up that'd be
> great.

This sounds like a generally scary idea.  Perhaps if you described
your problem at a higher level (what are you really trying to
achieve?) there would be a less scary way to do it.

That said, if you *really* need this... one option that comes to mind is:

1. extract the history from svn into git using 'git svn' as usual.

2. extract the subtree of svn that you're interested in (if you're
lucky enough that you only need one subtree) by using 'git subtree
split'.  This creates a new branch or new git repo, depending how you
do it.

3. Create a third project that will host your new work with extra
subtrees that you don't want.  Use 'git subtree add' and 'git subtree
merge' to keep this up to date with the stuff you extracted in step 2.
 (Repeat steps 1-3 as necessary to keep your project up to date with
the svn project.)

4. When you want to merge your own changes back into svn, first
extract them from your own project (step 3) using 'git subtree split'.
 Then merge those changes into the main project (step 1) using 'git
subtree merge'.  Then use git-svn to upload them to the main svn repo.

You can save yourself some steps if you import the *entire* svn
project into your own project, rather than trying to trim it on
import.  That way you only have to split when going from #3 to #1, not
in the other direction, and you don't need repository #2.

If all this sounds crazy, it probably is.  Maybe see if you can come
up with a way to avoid trying to do this altogether.

Good luck... :)

Avery

[1] http://github.com/apenwarr/git-subtree
