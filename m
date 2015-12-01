From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Tue, 1 Dec 2015 17:25:38 -0500
Message-ID: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
	<CAPig+cQMXgan0Hkm+HJt836Xm9AObxr8EW0DXb=puPzWD+v=Dg@mail.gmail.com>
	<CAGjXF72PgdjBw03ERVYxj+atvsBXK0LeJ6O3zTZgi3-kv9BWsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: James Rouzier <rouzier@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3tMl-0005vL-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 23:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbbLAWZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 17:25:39 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36415 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbbLAWZi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 17:25:38 -0500
Received: by vkay187 with SMTP id y187so13664314vka.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 14:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=zgYasvXe9Rxk2xfU4KuyJwzbdMc85xcxmgLuTCyKlis=;
        b=zWQcFbclw91roiLb4kNkp2GaN+8mUbboQBHbIgz+GObtsxuVhqbbe6enAD60HdXWeX
         VySBIWXmLBWU5/VDk6gZetLJmCzfKt1n7oSg2+IVyRtPqboU/dKATi6tORC40c5WaZkC
         J4t133ApMQ/4+0FNGCf2SeMNV5684MUqKYj/WVb3PYUQiq4NGoG3wGXbK0gR5VqYVa/l
         fcXpUehQMpprGdlXy9/m1WBR61bF6UoysABDP3KfymB3OMUJEQ8wisHSWAfHwPfsRhWz
         sgslZuhq7ahuqmGI7lXcncpjcEsSb0dkqe/xv3KU9ADNZQ658xHww2PC3WP00gwBakjH
         SUkw==
X-Received: by 10.31.134.3 with SMTP id i3mr60027335vkd.14.1449008738123; Tue,
 01 Dec 2015 14:25:38 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Dec 2015 14:25:38 -0800 (PST)
In-Reply-To: <CAGjXF72PgdjBw03ERVYxj+atvsBXK0LeJ6O3zTZgi3-kv9BWsw@mail.gmail.com>
X-Google-Sender-Auth: vr1xfZ102X-V4kKBq5BZjSysjO8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281859>

On Tue, Dec 1, 2015 at 4:36 PM, James Rouzier <rouzier@gmail.com> wrote:
> Eric thank you for the feedback.

[re-adding git@vger.kernel.org to recipient list since this response
was likely intended to be public]

> On Sun, Nov 29, 2015 at 9:24 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>> On Thu, Nov 26, 2015 at 9:44 AM, James <rouzier@gmail.com> wrote:
>> > From: James Rouzier <rouzier@gmail.com>
>> >
>> > Specify a file to read for exclude patterns.
>> > ---
>> > @@ -61,6 +61,9 @@ OPTIONS
>> >         $GIT_DIR/info/exclude, also consider these patterns to be in the
>> >         set of the ignore rules in effect.
>> >
>> > +--exclude-from=<file>::
>> > +       Read exclude patterns from <file>; 1 per line.
>>
>> s/;/,/ maybe?
>
> I copied this from Documentation/git-ls-files.txt to try and keep the
> documentation style consistent.
> However if it is believed to be better I will change it here and also in a
> separate patch for Documentation/git-ls-files.txt

I don't feel strongly about it. Existing precedence may be a good
argument in its favor.

>> Also, why move the memset() all the way up here as opposed, say, to
>> moving it just before the parse_options() invocation? Is it just to
>> make it easier for the next person who comes along wanting to
>> manipulate 'dir' early on (before git_config(), for instance)?
>
> Yes I want to make sure that the 'dir' is initialized before any usage.
>
>> > +               git clean -f --exclude-from=.git/clean-exclude &&
>> > +               test -e 1 &&
>> > +               test -e 2 &&
>> > +               ! (test -e 3) &&
>>
>> I see that you copied this from the "git clean -e" test, but it's not
>> obvious why parentheses are needed or wanted, and none of the other
>> tests use parentheses when negating the return of 'test', thus they
>> probably ought to be dropped.
>
> Ok will do
>
>> > +               test -e known
>>
>> Modern scripts would normally use test_path_is_file() and
>> test_path_is_missing() instead of 'test -e', however, you are again
>> matching existing style in this script, so 'test -e' may be
>> reasonable.
>
> Since it is the standard I could just take the time to upgrade 'test -e' in
> this test file to use newer standard.

This test script is probably relatively quiescent right now, so such
cleanup may be reasonable. Since it is conceptually distinct from the
purpose of the current patch, you would want to do the cleanup as a
preparatory patch, thus making this a 2-patch series.

>> > +test_expect_success 'git clean -e --exclude-from' '
>> > +       rm -fr repo &&
>> > +       mkdir repo &&
>> > +       (
>> > +               cd repo &&
>> > +               git init &&
>> > +               touch known 1 2 3 &&
>> > +               git add known &&
>> > +               echo 1 >> .git/clean-exclude &&
>> > +               git clean -f -e 2 --exclude-from=.git/clean-exclude &&
>> > +               test -e 1 &&
>> > +               test -e 2 &&
>> > +               ! (test -e 3) &&
>> > +               test -e known
>> > +       )
>> > +'
>>
>> Should a test be added which uses --exclude-from multiple times in the
>> same git-clean invocation?
>
> That does make sense will do.
>
>> Would it make sense add a test checking the behavior when the file
>> named by --exclude-from doesn't exist or is otherwise unusable as an
>> exclusion file?
>
> At the moment the add_excludes_from_file function will exit the program if
> there is a problem loading the exclude file.
> I could add a test for that behavior. In case in the future this behavior is
> changed.
