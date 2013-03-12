From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 18:11:14 -0400
Message-ID: <CAJELnLGenaFR1zeq=+2Ed6CCbog7q9aFm=B4PN2poJVhGxLBww@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
	<CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
	<CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
	<CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
	<20130312194306.GE2317@serenity.lan>
	<7vfw0073pm.fsf@alter.siamese.dyndns.org>
	<20130312210630.GF2317@serenity.lan>
	<CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 12 23:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFXQB-0002Us-NP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 23:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab3CLWLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 18:11:18 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:44647 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680Ab3CLWLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 18:11:15 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so321404pbb.32
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2Ry52nC7QaZEC7lFjv9tsjsiz4IFBiyTqYuLb9aIUiU=;
        b=quivmpNhjJCN6cJt8cUGRkfDeUfN/I4LWNNOE7YyRY+qNIj43Ya7cj0+DGw6lWxW9G
         mjIn1ufdHQsToCUzGtDcT8g791oeIxYG8vJqGlbVp+2Z1rbfOLlbkPBISmFGM7wGwULr
         SDIQVR1hYWJq23Td/YH6hUbXpl3thLZtJrlpAUSQmYaGd1eSPqWZ9OjLtjwLYxcK1/pm
         mBwI8HzXd+0Lp9GyjYZK4pls4vQorVDFefIES+m3sT5Hf8lRik7sQY6wmpvvN1VYGDNV
         ObWJ/7Zxd9b2rNoDzaL5lt2rB4B59F9m3gAeqVCc/zoGG7K7tYSh0q+vOpW8akfPiIIc
         3F6Q==
X-Received: by 10.68.31.130 with SMTP id a2mr33801627pbi.213.1363126274707;
 Tue, 12 Mar 2013 15:11:14 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Tue, 12 Mar 2013 15:11:14 -0700 (PDT)
In-Reply-To: <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218003>

On Tue, Mar 12, 2013 at 5:43 PM, Matt McClure <matthewlmcclure@gmail.com> wrote:
> On Tue, Mar 12, 2013 at 5:06 PM, John Keeping <john@keeping.me.uk> wrote:
>>
>> is it sufficient to say
>> "there is no more than one non-option to the left of '--' and '--cached'
>> is not among the options"?
>
> An alternative approach would be to reuse git-diff's option parsing
> and make it tell git-difftool when git-diff sees the working tree
> case. At this point, I haven't seen an obvious place in the source
> where git-diff makes that choice, but if someone could point me in the
> right direction, I think I'd actually prefer that approach. What do
> you think?

There's an interesting comment in cmd_diff:

/*
* We could get N tree-ish in the rev.pending_objects list.
* Also there could be M blobs there, and P pathspecs.
*
* N=0, M=0:
* cache vs files (diff-files)
* N=0, M=2:
*      compare two random blobs.  P must be zero.
* N=0, M=1, P=1:
* compare a blob with a working tree file.
*
* N=1, M=0:
*      tree vs cache (diff-index --cached)
*
* N=2, M=0:
*      tree vs tree (diff-tree)
*
* N=0, M=0, P=2:
*      compare two filesystem entities (aka --no-index).
*
* Other cases are errors.
*/

whereas inspecting rev.pending in the "compare against working tree"
case, I see:

(gdb) p rev.pending
$3 = {
  nr = 1,
  alloc = 64,
  objects = 0x100807a00
}
(gdb) p *rev.pending.objects
$4 = {
  item = 0x100831a48,
  name = 0x7fff5fbff8f8 "HEAD^",
  mode = 12288
}

Given the cases listed in the comment, I assume cmd_diff must
interpret this case as:

* N=1, M=0:
*      tree vs cache (diff-index --cached)

The description of that case is confusing or wrong given that
git-diff-index(1) says:

       --cached
           do not consider the on-disk file at all

***

cmd_diff executes this case:

else if (ents == 1)
    result = builtin_diff_index(&rev, argc, argv);

So it looks like I could short-circuit in builtin_diff_index or
something it calls -- e.g., run_diff_index -- to get git-diff to tell
git-difftool that it's the working tree case. I see that
run_diff_index does:

    diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");

So that looks like a good place where the code is already deciding
that it's the working tree case -- "w/", though surprisingly to me:

(gdb) p revs->diffopt
$12 = {
...
  a_prefix = 0x1001c25aa "a/",
  b_prefix = 0x1001c25ad "b/",
...

So diff_set_mnemonic_prefix doesn't actually use the "w/" value passed
to it because:

if (!options->b_prefix)
    options->b_prefix = b;

Maybe if I could prevent b_prefix from getting set earlier, I could
get some variant of git-diff to emit the "w/" for git-difftool.

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
