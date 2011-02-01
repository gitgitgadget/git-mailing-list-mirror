From: Andreas Ericsson <ae@op5.se>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 01 Feb 2011 15:42:12 +0100
Message-ID: <4D481BC4.2050104@op5.se>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1101311459000.8580@xanadu.home> <20110131210045.GB14419@sigill.intra.peff.net> <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHR3-00013Q-7T
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab1BAOmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:42:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33665 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab1BAOmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:42:16 -0500
Received: by fxm20 with SMTP id 20so6871134fxm.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:42:15 -0800 (PST)
Received: by 10.223.103.8 with SMTP id i8mr7502709fao.47.1296571335014;
        Tue, 01 Feb 2011 06:42:15 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id n3sm7881302faa.5.2011.02.01.06.42.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 06:42:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165810>

On 01/31/2011 10:28 PM, Nicolas Pitre wrote:
> On Mon, 31 Jan 2011, Jeff King wrote:
> 
>> On Mon, Jan 31, 2011 at 03:28:37PM -0500, Nicolas Pitre wrote:
>>
>>> We do have subdirectories for documentation, tests, contributions, etc.
>>> But a sizeable part of the tree is just a big splat of source files
>>> dumped right in the root of the tree.
>>>
>>> So I'd suggest doing the following:
>>>
>>> 1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and
>>>     the builtin directory from the root directory to it.
>>
>> Wouldn't this just be the same giant splat of source files, but in a
>> different tree? I don't really see the advantage, and it seems like an
>> extra annoyance.
> 
> Like I said to Junio, if you don't see the advantage, there's nothing I
> can do for you.  To me this is simple good source code hygiene.
> 
>> Besides being just one more directory to go up and down, it does make
>> history browsing more annoying. As much as I love git's "don't record
>> renames" philosophy, our handling of renames on the viewing side is
>> often annoying. I already get annoyed sometimes following stuff across
>> the s!builtin-!builtin/! change. This would be like that but more so.
> 
> So... we do suck at something?  So why not take this opportunity to
> shake yourself out of this easy comfort and improve Git as a result on
> both front?  :-)
> 
>> Or maybe it is a good thing for that reason, as we will eat our own
>> rename dogfood. :)
> 
> Exactly!  And maybe we'll make Git even more useful in the process.
> 
>>> 5) Rename t/ to testsuite/ so this doesn't look like some garbage
>>>     leftover.
>>
>> Ugh, more typing. :P
> 
> Come on!  You sound like an old fart now!  ;-)
> 

Personally, I kinda like the capital D in Documentation for tab
completion reasons. Keeping frequently used files and directories
with short unique prefixes makes perfect sense from a typing point
of view. Using longer mnemonic names makes perfect sense from a
regex search/replace point of view.

I'm kinda with Junio on the ./*.[ch] -> src/*.[ch] move though, but
perhaps that's just because I hate autoconf projects which generate
a ton of cruft in the root before one can even start building it.

It would probably help matters along if buildproducts ended up in
their own directory though. That way .gitignore won't have so many
extra commits when new source files are added, and 'make clean'
gets easier to maintain.

So to sum up what I'm for;

t/ -> Test/ (or Testsuite, but some more mnemonic name anyways
with a short unique prefix for tab completion). This would also
exercise our rename machinery quite a bit, altohugh not to the
point where people get annoyed if it gets sort-of-broken.

buildproducts to Build/ (capital B to avoid completing against
builtin*). This also has the benefit that %.o: %.c rules makes
tab completion work better when object files are already built,
and "git add git-foo.*" doesn't throw the "git-foo.o is ignored"
error and forces one to re-type it as "git-foo.[ch]"

The ppc stuff I don't really care about and it wouldn't be hard
to resurrect if we remove it and people complain. Everything
will also still work if we do, although with possibly a slight
decrease in performance.

Bulk of source-files stay as ./*.[ch]. I see absolutely no
benefit to moving them, but two potential drawbacks. One is that
it'll cause more typing for those of us who use console-based
editors and run 'make' manually (yes, we do exist). The afore-
mentioned merge+rebase hell is also a considerable drawback,
even though that's primarily an issue for maint releases.

Risks: Well... dunno about that really. Mucking up the build and
test systems, I suppose, but it's easy enough to test.

Cons: Rebasing and merging stuff to the Makefile and test-stuff
will suck a bit, but as has been pointed out that's not only a
bad thing.

Pros: Less typing all-round. Simpler "make clean" rules. Fewer
tacked-on .gitignore patches for new commands. We (well, Junio)
get to experience first-hand the problems of directory renames
across releases but on a smaller scale than moving *everything*
around in one go.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
