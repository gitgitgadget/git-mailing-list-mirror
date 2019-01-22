Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876961F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAVSTT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:19:19 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46083 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAVSTT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:19:19 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id m0dmgRORjAOoym0dngCUtV; Tue, 22 Jan 2019 18:19:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=iKrn8l-KAAAA:8 a=9AOhXYJeeC5VmRM5CYQA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes are
 symlinks
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190114230902.GG162110@google.com>
 <20190117170005.GA27667@sigill.intra.peff.net>
 <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
 <20190117212448.GA13100@sigill.intra.peff.net>
 <a0aef5a7-eb69-8dd8-abb7-4db6d1de4a26@ramsayjones.plus.com>
 <20190122072359.GE28555@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8ea563e7-8b3f-dc38-3aec-02253690b6b7@ramsayjones.plus.com>
Date:   Tue, 22 Jan 2019 18:19:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122072359.GE28555@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJhfMMbqhETw7F+1wv4d4YS9IUx+xtN7poiW5/PI3tDzVHs+wSX2qCQ7ahcHsFN1J3H45e8MdLd1vWb/wS6i27QWoyDQj3nmt/IQklS0bGylY9DJTVKe
 Qr8LtpA2qY4j27KFweX79jdNLLVHMmhKr6qhZ2ucRzvPdAqzr5332QFL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/01/2019 07:23, Jeff King wrote:
> On Fri, Jan 18, 2019 at 01:41:08AM +0000, Ramsay Jones wrote:
> 
>> I don't do this "from time to time", but *every* build on all
>> platforms! :-D
>>
>> As I have mentioned before, I run the script on 'master', 'next'
>> and 'pu', but I don't look at the results for 'master', I simply
>> look at the diffs master->next and next->pu.
> 
> Ah, ok, that explains it, then. As you noted, these made it straight to
> master because of the security embargo.
> 
> Thanks for satisfying my curiosity (and for running your script!).
> 
> I do wonder if you might be better off comparing master@{1} to master to
> see if anything new appears (since I assume the whole point is ignoring
> historical false positives, and just looking at patches under active
> development).

Hmm, well it's not so much 'historical false positives' as 'oh dear,
they managed to get through' (along with a promise to myself to get
around to tidying up the symbols in master - yet again!). ;-)

I try to make people aware of the issues, when they appear in 'pu',
so that we have a chance not to make things worse. However, it is
never as simple as 'this symbol is not used/local to this file,
please fix' (despite what it looks like, I don't like to annoy
contributors with those emails :-D ). Many recent large changes
have been split into several series with earlier series introducing
symbols which 'will be used later'. Sometimes later never comes. ;-)

Recently, Brian's 'bc/sha-256' branch merged into 'next', so now:

  $ diff sc nsc
  37a38,39
  > hex.o	- hash_to_hex
  > hex.o	- hash_to_hex_algop_r
  74a77,78
  > sha1-file.o	- hash_algo_by_id
  > sha1-file.o	- hash_algo_by_name
  $ 

Brian has already indicated [1] that future patches will add uses
for these symbols.

[1] https://public-inbox.org/git/20181114021118.GN890086@genre.crustytoothpaste.net/

[Just to be clear, my script only notes symbols that are not
referenced outside of the object file which contains its
definition - so that includes file-local and unused symbols].

There are currently 90 symbols in the 'sc' file, some of which
should be added to the outdated 'skip list'. Just FYI, the file
which has the most hits is:

  $ cut -f1 sc | sort | uniq -c | sort -rn
       26 config.o
        6 sha1dc/sha1.o
        6 refs.o
        6 json-writer.o
        3 utf8.o
        3 sha1-file.o
        3 revision.o
        3 refs/ref-cache.o
        2 vcs-svn/fast_export.o
        2 refs/packed-backend.o
        2 path.o
        2 parse-options.o
        2 graph.o
        2 attr.o
        1 worktree.o
        1 trace.o
        1 tmp-objdir.o
        1 tempfile.o
        1 strbuf.o
        1 serve.o
        1 sequencer.o
        1 refspec.o
        1 refs/iterator.o
        1 read-cache.o
        1 pkt-line.o
        1 oidmap.o
        1 line-log.o
        1 ident.o
        1 hex.o
        1 gettext.o
        1 fuzz-pack-idx.o
        1 fuzz-pack-headers.o
        1 editor.o
        1 credential.o
        1 convert.o
        1 builtin/pack-objects.o
  $ 

... and the symbols in that file:

  $ grep config.o sc
  config.o	- git_config_copy_section_in_file
  config.o	- git_config_from_file_with_options
  config.o	- git_config_from_parameters
  config.o	- git_config_get_bool_or_int
  config.o	- git_config_get_maybe_bool
  config.o	- git_config_get_pathname
  config.o	- git_config_include
  config.o	- git_config_key_is_valid
  config.o	- git_configset_get_bool
  config.o	- git_configset_get_bool_or_int
  config.o	- git_configset_get_int
  config.o	- git_configset_get_maybe_bool
  config.o	- git_configset_get_pathname
  config.o	- git_configset_get_string
  config.o	- git_configset_get_string_const
  config.o	- git_configset_get_ulong
  config.o	- git_config_set_multivar_in_file
  config.o	- git_config_system
  config.o	- git_die_config_linenr
  config.o	- repo_config
  config.o	- repo_config_get_bool_or_int
  config.o	- repo_config_get_int
  config.o	- repo_config_get_maybe_bool
  config.o	- repo_config_get_pathname
  config.o	- repo_config_get_ulong
  config.o	- repo_config_get_value
  $ 
  

ATB,
Ramsay Jones
