From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 6 Mar 2014 23:01:04 -0000
Organization: OPDS
Message-ID: <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
References: <20140304174806.GA11561@sigill.intra.peff.net> <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com> <20140305005649.GB11509@sigill.intra.peff.net> <xmqqy50oh45n.fsf@gitster.dls.corp.google.com> <20140305185212.GA23907@sigill.intra.peff.net> <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com> <53183506.5080002@alum.mit.edu> <20140306155626.GB18519@sigill.intra.peff.net> <5318A537.4010400@alum.mit.edu> <20140306174803.GA30486@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Christian Couder" <christian.couder@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:01:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhHv-0002Zg-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaCFXBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:01:10 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:60880 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbaCFXBI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 18:01:08 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0ZAEr9GFNOl3C4/2dsb2JhbABAGg6CeDuDXYU+uFwBAQIBAYEbF3RpAQGBHwEBFAEEAQEBAQIBCAEBGRUeAQEhCwIDBQIBAw4HAwICBSECAhQBBBoGBwkBDQYBEggCAQIDAYU4BwGCBxkMCTauKYVZmxEXgSmNMoJ2NYEUBI8zij2QeYJuPzw
X-IPAS-Result: Av0ZAEr9GFNOl3C4/2dsb2JhbABAGg6CeDuDXYU+uFwBAQIBAYEbF3RpAQGBHwEBFAEEAQEBAQIBCAEBGRUeAQEhCwIDBQIBAw4HAwICBSECAhQBBBoGBwkBDQYBEggCAQIDAYU4BwGCBxkMCTauKYVZmxEXgSmNMoJ2NYEUBI8zij2QeYJuPzw
X-IronPort-AV: E=Sophos;i="4.97,604,1389744000"; 
   d="scan'208";a="603426056"
Received: from host-78-151-112-184.as13285.net (HELO PhilipOakley) ([78.151.112.184])
  by out1.ip06ir2.opaltelecom.net with SMTP; 06 Mar 2014 23:01:00 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243567>

From: "Jeff King" <peff@peff.net>
> On Thu, Mar 06, 2014 at 05:41:27PM +0100, Michael Haggerty wrote:
>
>> > We can wrap that in "git replace --convert-grafts", but I do not 
>> > think
>> > grafts are so common that there would be a big demand for it.
>>
>> It's probably easier to wrap it than to explain to Windows users what
>> they have to do.
>
> How would Windows users get a graft file in the first-place? There's 
> no
> GUI for it! ;)

Now, now... It's dead easy using the git-gui and Notepad++, you can see 
and confirm the sha1's, copy and paste, and the graft file is a very 
easy format, so even wimps (windows, icons, menus, pointers aka mouse) 
folks can do it. (It worked for me when I needed it ;-)

The main point is that grafts are very easy to create [1], in that there 
is no object manipulation, while the replace mechanism does need a fresh 
object to be created that will 'replace' the old object. This 
manipulation can be perceived at least an awkward step. The replace 
mechanism needs to be at least as easy as the graft.

Something as simple as the 'git replace --graft $sha1 $parents' idea 
would make it very easy to deprecate the older graft process with this 
conceptually almost identical syntax. There are a few other 
documentation places that should also be updated when its sorted [2].

>
> It should be easy to do "--convert-grafts", though, and I think it 
> fits
> into the scheme we're discussing below.
>
>> > I think it would be nice to have a set of "mode" options for
>> > "git-replace" to do basic editing of a sha1 and install the result
>> > (technically you could split the editing into a separate command, 
>> > but I
>> > do not see the point in editing a sha1 and then _not_ replacing 
>> > it).
>>
>> If modifying without replacing is needed, it would be pretty easy to 
>> add
>> an option --stdout that writes the SHA1 of the modified object to 
>> stdout
>> instead of creating a replace reference.  That way what you want 95% 
>> of
>> the time is the default but there is still an escape hatch.
>
> Agreed. I had originally though that perhaps something like this 
> should
> be part of "hash-object", and that "replace" should farm out the work.
> But thinking on it more, it doesn't really make sense as part of
> "hash-object".
>
>> > Perhaps:
>> >
>> >   # pretty-print sha1 based on type, start $EDITOR, create a
>> >   # type-appropriate object from the result (e.g., using 
>> > hash-object,
>> >   # mktree, or mktag), and then set up the object as a replacement 
>> > for
>> >   # SHA1
>> >   git replace --edit SHA1
>
> Here's a rough series that gets us this far:
>
>  [1/4]: replace: refactor command-mode determination
>  [2/4]: replace: use OPT_CMDMODE to handle modes
>  [3/4]: replace: factor object resolution out of replace_object
>  [4/4]: replace: add --edit option
>
> It shouldn't be too hard to do "--graft" or "--convert-grafts" on top.
>
> I also noticed that doing:
>
>    git replace foo foo
>
> is less than friendly (we notice the cycle, but just barf). It's
> especially easy to do with "git replace --edit", if you just exit the
> editor without making changes.  Or if you make changes to an
> already-replaced object to revert it back, in which case we would want
> to notice and delete the replacement.
>
> So I think we want to have "git replace foo foo" silently converted 
> into
> "git replace -d foo" (but without an error if there is no existing
> replacement), and then "--edit" will just do the right thing, as it's
> built on top.
>
> I also noticed that the diff engine does not play well with 
> replacements
> of blobs. When we are diffing the trees, we see that the sha1 for path
> "foo" is the same on either side, and do not look further, even though
> feeding those sha1s to builtin_diff would fetch the replacements.  I
> think compare_tree_entry would have to learn lookup_replace_object 
> (and
> I suspect it would make tree diffs noticeably slower when you have 
> even
> one replace ref).
>
>> "git replace" could support some of the options that "git 
>> filter-branch"
>> can take, like --env-filter, --msg-filter, etc. (at least if the 
>> target
>> is a commit object).
>>
>> All of this would make it possible to build up the changes that you 
>> want
>> to integrate via "filter-branch" piecemeal instead of having to have 
>> a
>> single monster filter-branch invocation.  For example,
>
> Right. I was tempted to suggest that, too, but I think it can get 
> rather
> tricky, as you need to replace in a loop, and sometimes the exact
> objects you need aren't obvious.  For example, a common use of
> "--index-filter" is to remove a single file. But to remove
> "foo/bar/baz", you would need to loop over each commit, find the tree
> for "foo/bar", and then remove the "baz" entry in
>
> Still, I really like the workflow of having decent "replace" tools,
> followed by "cementing" the changes into place with a "filter-branch"
> run (which, btw, does not yet know how to cement trees and blobs into
> place). It lets you work on the filtering incrementally, and even 
> share
> or work collaboratively on it by pushing refs/replace).
>
> And as you mention, it could be a heck of a lot faster than what we 
> have
> now.
>
> -Peff
> --

Philip
[1] https://git.wiki.kernel.org/index.php/GraftPoint
[2] http://stackoverflow.com/q/6800692/717355 
