From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 21 Sep 2010 00:35:01 +0400
Message-ID: <20100920203501.GB23533@landau.phys.spbu.ru>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru> <vpqmxrevppb.fsf@bauges.imag.fr> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru> <vpq8w2yvonu.fsf@bauges.imag.fr> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru> <vpqiq22vp72.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl?ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:35:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxn54-0000iC-0o
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447Ab0ITUfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 16:35:05 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:39269 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0ITUfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:35:04 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 62111FF6FD; Tue, 21 Sep 2010 00:35:01 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100920182128.GB1790@sigill.intra.peff.net> <vpqmxrevppb.fsf@bauges.imag.fr> <vpq8w2yvonu.fsf@bauges.imag.fr> <vpqiq22vp72.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156660>

Matthieu, Jeff, Junio, thanks for your review and input.

Comments below inline...

On Sat, Sep 18, 2010 at 09:14:57PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > Recently I've spot a bug
> 
> We usually avoid the first person in commit messages. The cover letter
> is a good place to tell about your personal story, but the commit
> message is what will remain, what people will read after a blame or
> bisect. They won't care whether you've "recently" found a bug, or in
> which circumstances you've found it.
> 
> I'd write stg like (which would probably go to PATCH 2/3 instead of
> here):
> 
> -----8<----
> git blame --textconv is wrongly calling the textconv filter on
> symlinks: symlinks are stored as blobs whose content is the target of
> the link, and blame calls the textconv filter on a temporary file
> filled-in with the content of this blob.
> 
> For example:
> 
> >     $ git blame -C -C regular-file.pdf
> >     Error: May not be a PDF file (continuing anyway)
> >     Error: PDF file is damaged - attempting to reconstruct xref table...
> >     Error: Couldn't find trailer dictionary
> >     Error: Couldn't read xref table
> >     Warning: program returned non-zero exit code #1
> >     fatal: unable to read files to diff
> -----8<----

Agree, your wording is better.

> > So git-blame is wrong here, and I'm going to write problem-demonstration
> > tests + try to fix it, but first we have to convert existing textconv
> > converter, so it will mimic pdftext behaviour -- if there is no '^bin:'
> > in input -- it's not a "binary" file and helper exits with error.
> 
> What's interesting here is not that you mimick pdftext behavior, but
> that you allow to easily distinguish file content and symlink target.
> 
> Here's my try:
> 
> -----8<----
> The textconv filter is sometimes incorrectly ran on a temporary file
> whose content is the target of a symbolic link, instead of actual file
> content. Prepare to test this by marking the content of the file to
> convert with "bin:", and let the helper die if "bin:" is not found in
> the file content.
> -----8<----

Agree

> > No other semantic changes at this stage.
> 
> Otherwise, the code looks OK.

Thanks


On Sat, Sep 18, 2010 at 09:26:29PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > Subject: Re: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
> 
> We try to keep the subject lines short (<80 chars, and as much as
> possible less so that "git log --oneline" be pretty).
> 
> How about
> 
> blame,cat-file: add failing tests for --textconv on symlinks

I'd like to shorten it, but "add failing tests" is not as descriptive as
"Demonstrate --textconv misbehaves in such-and-such way", and I can't
come up with a shorter subject without making it more cryptic. And btw,
I've looked at log --oneline output, and (surprise, surprise)

479a56 4fccc04 etc ...

So if that's not a major obstacle, I'd leave it as is.

> > Because as described in previous patch - it should not.
> 
> Since the actual problem is exhibited here, I think it is the best
> place to actually describe it.

Agree - will move description here.

> > +test_expect_success 'make another new commit' '
> > +	echo "bin: test number 2" >three.bin &&
> > +	echo "bin: test number 2 version 2" >>three.bin &&
> > +	echo "bin: test number 2 version 3" >>three.bin &&
> > +	echo "bin: test number 3" >>three.bin &&
> 
> cat >three.bin <<EOF
> bin: test number 2
> bin: test number 2 version 2
> bin: test number 2 version 3
> bin: test number 3
> EOF
> 
> ?

Yes, thanks.

> > +cat >expected <<EOF
> > +(Number1 2010-01-01 18:00:00 +0000 1) converted: test number 2
> > +(Number2 2010-01-01 20:00:00 +0000 2) converted: test number 2 version 2
> > +(Number3 2010-01-01 22:00:00 +0000 3) converted: test number 2 version 3
> > +(Number4 2010-01-01 23:00:00 +0000 4) converted: test number 3
> > +EOF
> 
> These days, it's recommanded to put this kind of code within the
> test_expect_success/test_expect_failure.

I see, thanks.

I've moved other >expected preparation inside test_expect_*, but this
expect is special in that it is used in subsequent two tests. So I'd
leave this one outside.

And btw, I've originally copied in-style what was already there in t8006
and t8007 which date to Jun 2010.

> > +
> > +echo -n "one.bin" >expected
> 
> echo -n is not very portable (and doesn't seem to be used in git's t/
> directory). Better use
> 
> printf "%s" "one.bin" >expected
> 
> (again, within text_expect_failure if possible)

I didn't knew echo -n is not portable, thanks. Converted to printf and
moved inside test.


On Sat, Sep 18, 2010 at 09:04:00PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > I don't know blame code well, and I'm not sure I'm doing it right or
> > otherwise without mistakes. Thus an RFC.
> 
> I don't know the code well either, but I didn't see any obvious
> problem in your code.
> 
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -1068,7 +1068,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
> >  		struct cache_entry *ce;
> >  		int pos;
> >  		if (namelen > 2 && name[1] == '/')
> > -			return get_sha1_oneline(name + 2, sha1);
> > +			return get_sha1_oneline(name + 2, sha1);    /* XXX also mode? */
> 
> (This is the case where we're parsing ":/foo")
> 
> Currently, the mode is set a few lines above:
> 
> 	oc->mode = S_IFINVALID;
> 
> I guess this is OK since :/foo will return a commit sha1, not a file
> sha1.

Ah, yes, thanks. I forgot ':/text' means `commit which log is text' -
yes, mode should be S_IFINVALID here then.

> > @@ -1095,6 +1095,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
> >  				break;
> >  			if (ce_stage(ce) == stage) {
> >  				hashcpy(sha1, ce->sha1);
> > +				oc->mode = ce->ce_mode; /* XXX ok? */
> 
> I'd say this is OK, you're setting the mode from the index. What was
> the reason for your question mark?

Yes, this turned out to be needed - without this copy, one of cat-file
tests does not pass.

I was worrying because initially I've also tried to propagete
origin->mode into ce->ce_mode in fake_working_tree_commit():

--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2133,9 +2133,9 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 	hashcpy(ce->sha1, origin->blob_sha1);
+	ce->ce_mode = create_ce_mode(origin->mode);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, 0);
-	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 
 	/*

and it caused test failures, e.g.

    --- expected    2010-09-20 20:26:53.000000000 +0000
    +++ result      2010-09-20 20:26:53.000000000 +0000
    @@ -1 +1 @@
    -(Number2 2010-01-01 20:00:00 +0000 1) two.bin
    +(Not Committed Yet 2010-09-20 20:26:53 +0000 1) two.bin
    not ok - 9 blame with --no-textconv (on symlink)
    #
    #               git blame --no-textconv symlink.bin >blame &&
    #               find_blame <blame >result &&
    #               test_cmp expected result
    #

in t8006-blame-textconv.sh

So I dummily conclude I'de better not touch ce_mode...

But now I read comments in there 

        /*
         * Read the current index, replace the path entry with
         * origin->blob_sha1 without mucking with its mode or type
         * bits; we are not going to write this index out -- we just
         * want to run "diff-index --cached".
         */

And guess I probably should not touch mode here. Not 100% sure, but more
confident (call it heuristic programming :)), so I'm removing my XXX.


On Mon, Sep 20, 2010 at 02:21:28PM -0400, Jeff King wrote:
> On Sat, Sep 18, 2010 at 09:25:06PM +0400, Kirill Smelkov wrote:
> 
> > Instead get the mode from either worktree, index, .git, or origin
> > entries when blaming and pass it to textconv_object() as context.
> > 
> > The reason to do it is not to run textconv filters on symlinks.
> 
> I think this is absolutely a bug, and your solution is definitely in the
> right direction. We obviously can't just ignore the mode when deciding
> whether to textconv. I suspect there is similar breakage for S_IFGITLINK
> files, though they are perhaps less likely in practice to match another
> filetype's extension.
> 
> So all three patches look sane to me, with the caveat that I also don't
> know the blame code very well.
> 
> I agree with Matthieu's points on cleaning up the commit messages, and
> there is a small comment typo in this third patch:

Jeff, thanks for you comments - appreciated.

> > @@ -313,21 +315,23 @@ static struct origin *get_origin(struct scoreboard *sb,
> >   * for an origin is also used to pass the blame for the entire file to
> >   * the parent to detect the case where a child's blob is identical to
> >   * that of its parent's.
> > + *
> > + * This also fills origin->mode for correspoinding tree path.
> 
> Typo: s/poind/pond

Good eyes, thanks.

I should sleep more :)



Thanks again to everyone. I'll repost this series as v2 shortly.

Kirill
