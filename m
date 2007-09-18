From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 18:53:45 +0100
Message-ID: <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com>
References: <20070917193027.GA24282@old.davidb.org>
	 <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Sam Vilain" <sam@vilain.net>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:54:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXhGm-00059X-RC
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 19:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759142AbXIRRxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756922AbXIRRxu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 13:53:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:5263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbXIRRxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 13:53:49 -0400
Received: by ug-out-1314.google.com with SMTP id z38so133662ugc
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nr75VWdmQ4MPGlLghx5U4TZrqxBUP+QQWNehlpw26KU=;
        b=IGtkc+XTsXXHC/M0EtTHpcT81ud3dWF9TKZEDvW7vxSjr21fcG/xgsTAZLIaCcrYYz9Tspzx+rG9Rs3+eKmGYHQvqvaN7AS+DstiLoVLMYBaOf9zi34EurzZ+AQHdQF5igDPplY1zsWnLNSQ+0keJx3kVu5nsDv8dKybF2OKo3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jfXDFS1eQdPiZ8LPrOEJk50yJ3/r/mY7VSj4yx0zUBxDhCjfviHdq+VCa8KaR5iXNJ3ze0YkGoMpfHahkNnVEwtGg7uev6vWz/C8RZibwY6P6F4LPfAyHN2JY3EaID5c+eYmAeGEcGn4nAowJ4oqyhWjt83ckKlcv7zZ+h5Y+O4=
Received: by 10.142.212.19 with SMTP id k19mr24906wfg.1190138025584;
        Tue, 18 Sep 2007 10:53:45 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Tue, 18 Sep 2007 10:53:45 -0700 (PDT)
In-Reply-To: <20070918154918.GA19106@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58627>

On 18/09/2007, David Brown <git@davidb.org> wrote:
> On Tue, Sep 18, 2007 at 07:27:13PM +1200, Sam Vilain wrote:
>
> >I'm pretty close to giving a newer one a spin, that actually imports
> >from the raw perforce back-end files without needing the perforce
> >server.  I am hoping that this should give a very clean import and will
> >be very fast and efficient, sending files that share ancestry to gfi in
> >sequence so that the on-the-fly delta system works.
>
> Unfortunately, this isn't something I'm going to be able to use.  The
> Perforce server will remain live, and resides on a machine I don't have
> access to.

I use git-p4 in the same way. The best approach would be to have both
tools and to use whichever one best matches your needs.

> >It could possibly be adapted to use the p4 client (though I'd expect
> >that to be relatively slow per-revision), and possibly be extended to be
> >bidirectional as all of the upstream change number information is
> >recorded, a la git-svn.
>
> I was able to get 'git-p4' to work a lot better by using @all, but it still
> has some problems, at least bad interactions with P4.

I have also seen this.

>    - It doesn't use any client spec.  Our P4 server space is a complete
>      mismash and has to be fixed up to get a sane directory layout.  For
>      example, some revisions have hundred-MB tar files sitting in the root
>      directory and I don't want that in the repo.  I also need to exclude
>      directories, and in some cases completely rearrange the directory
>      layout.

The directory exclusion you could do the other way, if git-p4
supported multiple directory paths.

The main issues with using client workspaces is that they require you
to use `p4 sync`, whereas git-p4 uses `p4 print` and that they may
change as the repository changes, but Perforce does not track these
changes.

That said, something like what workspaces are doing (allowing you to
specify multiple paths and where they are to go) would be useful.

>    - Our P4 server is set to be case insensitive.  'git-p4' ignores paths
>      that come back from the server that are specified using a different
>      case.  Unfortunately, this means that a handful of files just get
>      randomly dropped from each revision.

It is worse than this. If you have:

    p4 integrate foo Foo
    p4 delete foo

then git-p4 will completely remove the file foo from the repository! I
reported this a while back, but did not get a reply.

This is something I want to fix, as doing an '@all', rebase or sync is
broken in this case when dealing with renamed files as above when
importing a repository on a case insensitive system.

The alternative is to do the importing from Perforce on a Linux
machine and then clone/pull/rebase from it on a Windows machine.

>      I tried importing a client path instead of a depot path, but the names
>      that come back from 'p4 files' are depot based so none ever match.  I
>      end up with a nice revision history of entirely empty trees.

Ideally, git-p4 should bail out here with an error about the path
needing to be specified as a depot path.

> I'm probably going to end up writing an importer that uses an actual client
> workspace to let Perforce do the client mapping.

As eluded to above, I want to extend git-p4 to support a
workspace-like importer map file to use instead of a specific depot
path (with a single depot path being supported as well for backward
compatibility and simplicity if the repository you are importing from
has a simple layout).

There is no need to create yet another Perforce importing tool, git-p4
works well in most cases. If we focus on improving git-p4, extending
it to support the functionality mentioned here, fix the issues that
there are with it, then that will be more beneficial to the community
as they will not have to learn another tool with a different set of
bugs and issues.

> I'm also going to have to
> put some work into some code to clean up the log messages, since most of
> our changes have as a first line "New Features:", which makes for a rather
> uninformative shortlog.

I would not do that. It is a good idea to keep the original log
messages, even if it does make for an uninformative shortlog. Look at
some of the CVS/SVN imported logs!

- Reece
