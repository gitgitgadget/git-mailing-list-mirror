From: Max W <max.w.7777777@googlemail.com>
Subject: Re: .gitattributes on branch behaves unexpected. Should it be more stateless?
Date: Sun, 18 Jan 2015 18:14:27 +0100
Message-ID: <CAGJ-DzFos0DHNettfSHp0HfCGKqC8agvqELezi6HLqWpob5f_g@mail.gmail.com>
References: <CAGJ-DzH0meYgpE8My+UW4wbTxs6vo=wrgo0o21Lzh5Hg38ibEQ@mail.gmail.com>
	<B551DC4135DC4DA3B8BA5E1BBA36BBEC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCtQo-0005GH-PQ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 18:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbbARROa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 12:14:30 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43058 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbARRO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 12:14:29 -0500
Received: by mail-wi0-f179.google.com with SMTP id l15so2621000wiw.0
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h47bksUoH07KE0MxXaaU9/xAN1mDPbGn7JmJeD2Lkxg=;
        b=DtFwMipDps13c9w1j8zsq5WFFcbZ37hwdagsO3q4JqxLjK8spSQ3ntKj9taCKrvB0s
         sSxxcmW6Biu6JvtiO4mkwc3s1y5DpZTo4sIdwtJojo1wzY3WyeJqhIZFCdKB8rCuM9dU
         mjocxoIb2WAKaG42up5TEVEPL+emd8zq3/Cqj1VkPFLEhv/vgERoTWrhfkpvqXKRSXwe
         n3mrMJKP2bDfSnubkdQoPeuGiD0B/phuHBtUaLyZum8XYZIzzJ0MEis8lZcVlzoeYjss
         omEykgs4FA1WEVDA3Epc/P3pwErRZjoe+5dGr+oRDwIJPubtBS/Df0E6QexJGK2MxBtX
         0L8Q==
X-Received: by 10.180.83.228 with SMTP id t4mr27371035wiy.28.1421601267919;
 Sun, 18 Jan 2015 09:14:27 -0800 (PST)
Received: by 10.27.178.134 with HTTP; Sun, 18 Jan 2015 09:14:27 -0800 (PST)
In-Reply-To: <B551DC4135DC4DA3B8BA5E1BBA36BBEC@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262604>

Hi philip,

thanks for your reply.

> You don't say which parts you believe should be identical, nor why.
I expected my representation to be identical, nevertheless what path
I have taken to come there. e.g.
git clone -b <branch>
git clone; git checkout <branch>
should result in a binary-indentical representation of the files
tracked by git. But they don't.

Why did I expect this? Good question. Feels more intuitive for me.
Like "don't worry what you have done before. When your HEAD is on a
certain commit, git will make sure all your files in your filesystem
are they way you (and the other committers) want them to be".

> [..]
> Does that help?
Yes, it helped me to distinguish better between data and representation.
New understanding: .gitattributes determines how to represent data.

As .gitattributes is under git control there can be 2 versions of
.gitattributes in 2 branches. So I can tell git
- on branch foo with gitattributes * eol=LF show me all files with LF
- on branch bar with gitattributes * eol=CRLF show me all files with CRLF
But this doesn't work. The representation of the files is
determined/depending on how I cloned or fetched the repo. A "git checkout
bar" does not change the representation.

Does this help to show where my concerns / my issue is?

Best Regards,
Max



2015-01-17 14:16 GMT+01:00 Philip Oakley <philipoakley@iee.org>:
>> Hi,
>>
>> I am asking myself if git and .gitattributes should be more stateless?
>> i.e.
>> whatever you have done before is irrelevant, when you reach status XYZ
>> with your
>> git repo, it is EXACTLY and BINARY the same all the time and everywhere.
>>
>> It took some time for me to figure out, that depending on HOW you clone,
>> the
>> resulting local repo may differ. I did not expect this. I assumed that
>> when I
>> clone, it is a clone (meaning: 100% identical). And that the things I have
>> done
>> in my local repo before, don't have any relevance at all.
>>
>
> You don't say which parts you believe should be identical, nor why.
>
> Internally Git can represent its object store in many ways based on some
> objects being 'loose' and some objects being 'packed'. However both styles
> of representation are of the same base objects and their contents.
>
> Then we have external OS representation, in particular the end of line
> representations between the three main OS types Win/Mac/'nix. Git gives
> _you_ the ability the use any of these representations for the same base
> objects. Thus the object file with text "Hello World/EOL/Goodbye World" will
> have three different binary representations once you export them to the
> selected file system type (according to you .gitattributes settings).
>
> If you always select LF endings for text files (both on the way in and on
> the way out of the repo), then you will get identical files on the different
> clones. Git has many settings for personalisation.
>
> Does that help?
>
>>
>>
>> ** How to reproduce **
>> 1) create a repo, add a file with LF ending, add a .gitattributes telling
>> git to
>>   do a CRLF conversion
>> 2) clone the repo
>> 3) on brach development, change .gitattributes to LF
>> 4) clone again
>> 5) clone again, directly onto the branch development (git clone -b)
>>
>>
>> ** Expected result, (I) **
>> clone 2) and original repo 1) are bytewise identical
>>
>> ** Actual result (I) **
>> clone 2) and original repo 1) differ, 1) has LF, 2) has CRLF
>> as I have been warned before, I am (more or less) fine/OK with this
>>
>>
>> ** Expected result, (II) **
>> - clone without -b (4) and clone with -b (5) are bytewise identical
>> - I would have expected, that whatever I do, as soon as I have a clone and
>> I am
>>  on branch "development", my file should be LF
>> - I would have expected, that HOW you clone is irrelevant
>>
>> ** Actual result (II) **
>> without -b (4) I have a CRLF file on my disk. with -b (5) I have a LF file
>> on my
>> disk. The clones are not bytewise indentical. It appears as if the
>> .gitattributes in branch development does not have any reliable effect.
>>
>>
>>
>> A potential solution might be be that
>> - checkout
>> - commit (a modified .gitattribues)
>> - <further git commands>
>>  do change the files in the local repo.
>> As of now my understanding is that this is not how .gitattributes (or
>> .gitignore) are designed. .gitattributes only has influence on
>> pushing/fetching.
>>
>> I don't know if and which side effects would occur if this design would be
>> changed. Hence I am glad to hear any feedback on the issue described
>> above. And
>> yes, I agree that this is a minor issue and that all .gitattribute things
>> are
>> kind of edge cases.
>>
>> Thanks and with best regards,
>> Max
>>
>>
>>
>>
>>
>>
>> 1)
>> mkdir git-bug-or-feature
>> cd git-bug-or-feature
>> git init
>> echo "foo.bar eol=crlf" > .gitattributes
>> echo "hello world" > foo.bar
>> git add .
>> git commit -m "now crlf"
>> # [master (root-commit) 7f3f6b0] now crlf
>> # warning: LF will be replaced by CRLF in foo.bar.
>> # The file will have its original line endings in your working directory.
>> file foo.bar
>> # foo.bar: ASCII text
>> cd ..
>>
>> 2)
>> git clone git-bug-or-feature git-bug-or-feature_clone
>> cd git-bug-or-feature_clone
>> file foo.bar
>> # foo.bar: ASCII text, with CRLF line terminators
>> cd ..
>> rm -rf git-bug-or-feature_clone
>>
>> 3)
>> cd git-bug-or-feature
>> git branch development
>> git checkout development
>> echo "foo.bar eol=lf" > .gitattributes
>> git add .
>> git commit -m "now lf on branch development"
>> file foo.bar
>> # foo.bar: ASCII text
>> git checkout master
>> file foo.bar
>> # foo.bar: ASCII text
>> cd ..
>>
>> 4)
>> git clone git-bug-or-feature git-bug-or-feature_clone
>> cd git-bug-or-feature_clone
>> file foo.bar
>> --
>
> philip
