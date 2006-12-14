X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Wed, 13 Dec 2006 22:06:31 -0700
Message-ID: <6efbd9b70612132106q4ef2a323se743bfd6378d15d3@mail.gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
	 <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
	 <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
	 <Pine.LNX.4.64.0612131156500.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 05:06:53 +0000 (UTC)
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0amyEAQqG4kw90EiV1XEahd+RqfQj3OTE43f/ykBvpbIqTNOHIx+8JEvlTBReRZUc9RZfZokTU1ZLoup4Ht3zu6lBlVRm0IbRDwCnaZjopb+edzFc9RAGXGR5pffCwFVHgVFPEiobotUsyAOfRbULdfqrwK2m95rfrTH1bkxw8=
In-Reply-To: <Pine.LNX.4.64.0612131156500.20138@iabervon.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34278>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guiny-0007iJ-6N for gcvg-git@gmane.org; Thu, 14 Dec
 2006 06:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751489AbWLNFGd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 00:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWLNFGd
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 00:06:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:17164 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751489AbWLNFGc (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 00:06:32 -0500
Received: by wx-out-0506.google.com with SMTP id h27so349018wxd for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 21:06:31 -0800 (PST)
Received: by 10.70.40.1 with SMTP id n1mr868406wxn.1166072791702; Wed, 13 Dec
 2006 21:06:31 -0800 (PST)
Received: by 10.70.59.14 with HTTP; Wed, 13 Dec 2006 21:06:31 -0800 (PST)
To: "Daniel Barkalow" <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

So, I've been making little repositories for appropriately related
stuff.  For example, I have a repository for my ~/.bashrc,
~/.bash_profile, ~/.bash_completions/*, and such.

I recall Linus's post in the "VCS Comparison Table" thread, and after
thinking about it, I decided the best thing to do would be to have a
couple extra files tracked in the repository, alongside other data.

I use a backup shell script to copy things from my system to the
repository, and then I run getfacl on it all to write out all the
details to a 'facl' file in my repository.  Then I can make a commit.

Then there's a restore shell script to copy things back to my system,
and restore ownership and permissions with setfacl.

I store the backup and restore scripts in the repository.  Paths are
currently hard-coded.  I'm sure there's a more flexible way to do
this, though I'd need some means of representing the correspondence
between content in the repository and files in my filesystem.


On 12/13/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 12 Dec 2006, Kyle Moffett wrote:
>
> > Hmm, ok.  It would seem to be a reasonable requirement that if you want to
> > change any of the "preserve_*_attributes" config options you need to blow
> away
> > and recreate your index, no?  I would probably change the underlying index
> > format pretty completely and stick a new version tag inside it.
>
> You should be able to promote an insufficient-version index to a
> new-version index that's needs to be refreshed for every entry. (And then
> update-index would take care of the necessary rewrite-everything in the
> normal way). But I suspect that the right thing is to require that the
> repository be created with a "commits-include-directories-not-trees" flag,
> and this means that you always use the extra-detailed index, and the
> options only affect what information is filtered out in transit between
> the directory object and the index. Having more information in the index
> is merely a potential waste of space, not a correctness issue (we have
> extra information for trees in the index now, remember); it just means
> that there are more things that will cause git to reread the file, rather
> than declaring it unchanged with a stat().
>
> For that matter, it may be best for the directory objects to record what
> information in them is real, and keep the "what's content" mask in the
> index as well. If it changes over the history of a repository, you want to
> correctly interpret the historical commits.
>
> > Ok, seems straightforward enough.  One other thing that crossed my mind
> was
> > figuring out how to handle hardlinks.  The simplest solution would be to
> add
> > an extra layer of indirection between the "file inode" and the "file
> data".
> > Instead of your directory pointing to a "file-data" blob and
> "file-attributes"
> > object, it would point to an "file-inode" object with embedded attribute
> data
> > and a pointer to the file contents blob.
> >
> > I remember reading some discussions from the early days of GIT about how
> that
> > was considered and discarded because the extra overhead wouldn't give any
> real
> > tangible benefit.  On the other hand for something like /etc the added
> > benefits of tracking extended attributes and hardlinks might outweigh the
> cost
> > of a bunch of extra objects in the database.  A bit of care with the
> > construction of the index file should make it sufficiently efficient for
> > day-to-day usage.
>
> I was thinking this could be internal to the directory object, but you
> probably want to support hardlinks shared between dentries in different
> directory objects, so you're probably right that this makes sense.
>
> Alternatively, you could use a single "directory" object for the whole
> state (including subdirectories), making hardlinks out of the object
> clearly impossible, or you could use some scheme for sharing
> sub-"directory" objects that would imply that hardlinks are within an
> object (the hard part here is finding things when their locations aren't
> predictable by name).
>
> 	-Daniel
> *This .sig left intentionally blank*
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
epistemological humility
