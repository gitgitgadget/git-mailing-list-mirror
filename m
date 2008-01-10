From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] - Added recurse command to git submodule
Date: Thu, 10 Jan 2008 10:50:47 +0600
Message-ID: <7bfdc29a0801092050q47848089g154399b470acb115@mail.gmail.com>
References: <1199857906-26321-1-git-send-email-imyousuf@gmail.com>
	 <7vmyrfjsw1.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580801090242g3f755814pa56e896d0a8723bb@mail.gmail.com>
	 <7vhchmhhjv.fsf@gitster.siamese.dyndns.org>
	 <7bfdc29a0801091927v4eb65a60qf5b185924b9d1e44@mail.gmail.com>
	 <7vy7ay8gpq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 05:51:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCpNv-0006zB-3R
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 05:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYAJEuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 23:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756732AbYAJEuv
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 23:50:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:46728 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYAJEuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 23:50:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so534660fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iDyfpeIVkvXDDMkR8n2R476i8cvZCVg4BK8XfyO+tdg=;
        b=tGuA4YxvSGlytRB4v0fDI9Veja586CdkU+Zxak4SAz8RzcvpCbrqBvjg6ciyeM/sb2IF4+MRSO95wxHa9DViUq28FN7RWnerG28SqPArFIWkIkAggcFxYl70CMtMCJzeoTZEdxBTy9N6vrvw4/SvM3e/YMjHVty3ZAuq+w/7yQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eXJOzzQB7N+JSyydoJx1cmTGX5N4iNGFJVuRahJ6SKOrKI9JaZV3tn2H5OXIeFbjCBTy24yzAcRASO6G5v1ZXj4eJAsIgq+WnXnrX/zmvre6eWMeuEuYnIgVa2rjwK1mSKGFVCP+xE68fOdzhRwxCFcYV7qNdIMSw4wiyiKo6w8=
Received: by 10.78.129.16 with SMTP id b16mr1681653hud.39.1199940647910;
        Wed, 09 Jan 2008 20:50:47 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 20:50:47 -0800 (PST)
In-Reply-To: <7vy7ay8gpq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70042>

On Jan 10, 2008 10:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
> >> Also, some commands cannot be made recursive by driving them
> >> from a higher level recursive wrapper.  "git submodule recursive
> >> log" would not make much sense, not only because the order of
> >> the log entries are output from different invocations would not
> >> be useful, but because the revision range specifier would need
> >> to be different in different submodules (e.g. library submodules
> >> and application submodule will not share version name namespace,
> >> i.e. "log v1.0..v2.0" is undefined, and worse yet, running "log
> >> v1.0:path/to/sub..v2.0:path/to/sub" in a submodule when running
> >> "log v1.0..v2.0" in the toplevel is not a correct solution
> >> either in general).
> >
> > What is you suggestion in such cases Junio?
>
> Not doing it using the wrapper approach, but actually have the
> underlying command be aware of the recursiveness.

Yes, I do agree fully that the wrapper approach has problem in
recursing; as I mentioned earlier it is the user who has to be aware
of the command he wants to execute recursively; as all currently
available work can still be performed even if the wrapper recurse is
added. But at least having recurse would allow users to execute
certain simple commands from the top level which otherwise would have
required to be done from each sub-module.

>
> Let's take a small example of library project contained within
> an application project as a submodule (think of ffmpeg in
> mplayer or something like that).
>
> Library project has this history:
>
>              3---A
>             /
>     ---1---2---4---B
>
> while the application project has this history:
>
>     ---5---X---6---Y
>
> and at time X (and before that point), it binds commit A at a
> directory "lib/" as a submodule.  The commit 6 (between X and Y)
> changes it to bind commit B there instead.  You have both
> toplevel and submodule checked out.  The HEAD in the application
> project is at Y while the HEAD in the library project is at B.
> Your work tree may or may not be clean.
>
> How would a recursive "git diff" between two versions should
> behave, with various arguments?
>
>         $ git diff X Y
>
> Currently this will say something like:
>
>         --- a/lib
>         +++ b/lib
>         @@ -1 +1 @@
>         -Subproject commit A
>         +Subproject commit B
>
> You can make it recurse naturally by recursing into lib/
> subproject instead (at least conceptually this is a simple
> change but it may not be so straightforward, implementation
> wise).
>
> How would you handle this, then?
>
>         $ git diff X Y -- Documentation/
>
> A wrapper approach that blindly descends into lib/ and runs "git
> diff X Y -- Documentation/" there is wrong at two levels.
> Commits X and Y do not even exist there, and Documentation/
> pathspec is wrong.  The documentation may be called docs/ in the
> library project, or it may not even exist, and that is not what
> the user asked to see anyway.  If the user were interested in
> the documentation of the library, the pathspec would have said
> lib/Documentaiton/ (or lib/docs/).
>
> For "git diff", the right solution happens to be invoking the
> command recursively without any pathspec.  The higher level
> chose to recurse into the directory already because it saw
> changes --- by definition everything underneath is interesting.
>
>         Side note.  If we support asking for lib/docs/ from the
>         toplevel, the recursive one would use docs/ as its
>         pathspec in this case.
>
> The point is that pathspec needs to be munged from the higher
> level iteration, and more importantly that is pretty much
> specific to "git diff".  "git diff" itself needs to have the
> knowledge of what to do when working recursively --- wrapper
> approach would not work well.

Yes, it is absolutely right that if the command was aware of the
recursion it could necessary measures to ensure that it can fallback
to default execution; e.g. remove the path spec from git-diff.
Alternatively, the recurse module could actually check whether if
simply passed the command would generate error or not; if yes then
display a message mentioning it and fallback to simplest form of the
command. The real disadvantage is that, firstly in this approach the
command gets executed twice in average case and secondly, the module
will have to know the fallback version of the command.

>
> How would a recursive version of "git log" work, then?
>
>         $ git log X..Y
>
> Again, a naive wrapper approach of descending into lib/ and
> running "git log X..Y" recursively would not give us anything
> useful.
>
> But if "git log" itself knew recursive behaviour, it should be
> able to do much better.  It can show Y and 6, and at that point
> it could notice that between 6 and its parent X the commit bound
> at lib/ as submodule has changed from A to B, so it could insert
> the log from submodule there.  If we were running with
> --left-right, we might see something like this:
>
>         >Y
>         >6
>             >B
>             >4
>             >2
>             <A
>             <3
>             -2
>         -X
>
> If the toplevel "git log" was invoked with a pathspec, again, it
> needs to be adjusted to submodule.
>
> I think a wrapper approach could be adequate for simple things
> like "checking out the whole tree including all of its
> submodules".  But even that has to be done carefully.
>
> What should this command (recursive version) do?
>
>         $ git checkout X
>
> The toplevel detaches head at commit X, and notices that it
> contains a submodule at lib/ whose HEAD now needs to point at
> A.  The recursive command should go there, and say
>
>         $ git checkout A
>
> What should it do when this checkout cannot be made because your
> work tree is not clean?  Ideally, it should abort and roll-back
> the checkout of commit X at the toplevel (otherwise you will end
> up in a mixed state).
>
> There are more interesting issues when you bring up a situation
> where X and Y binds that library project at different place
> (i.e. submodule was moved inside the toplevel), which I avoided
> to talk about here to keep this message short.
>

Thank you for the detailed explanation and I can visualize more
scenarios which you did not mention. From this I get the following
ideas for the recurse command -

1. Instead of supporting all he git commands support a subset with
limited feature

2. Support full range of git commands, as is submitted in this patch,
but if error occurs in execution fall back to the default version of
the command. This is probably not a efficient version; but would be
beneficial as other commands will not be effected.

3. Support full range of git commands, as is submitted in this patch,
leave it to the user on how he wants to use it.

4. Scrap the recurse idea (I actually do not prefer it :)).

Let me know which one you prefer (please not 4 :)).

>
>

Best regards,

-- 
Imran M Yousuf
