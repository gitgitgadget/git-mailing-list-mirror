From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-p4: Fetch the proper revision of utf16 files
Date: Fri, 3 Apr 2015 18:49:13 -0400
Message-ID: <CAPig+cT6DAu-AF-tKU=SKvh89imG_T2NfLCYxN6AsLe97CkPVw@mail.gmail.com>
References: <1428095627-8772-1-git-send-email-git@dbingham.com>
	<1428095627-8772-2-git-send-email-git@dbingham.com>
	<CAPig+cT59B-ccvbfyPvVt_1dTO7jFPn7YQdhu81WSz_1WFM2GA@mail.gmail.com>
	<CAFzU1R+m8Gw3O_HHKmKq0rTALh+TJ1kK84=L2rsGCNft4XcT=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, luke@diamond.org,
	Pete Wyckoff <pw@padd.com>
To: Domain Admin <daniel@dbingham.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeAOu-0007V1-0o
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbbDCWtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:49:16 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36230 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbDCWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:49:15 -0400
Received: by lbbug6 with SMTP id ug6so86194905lbb.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wuBsEMsrkAS62TUzdbVT2u9DcG7U/xFZ9m5n8Ry+pus=;
        b=ErCVlfZ/AZW/qulMaqhdcBdH85TnKgQ+hm7KrpdgdJAmkHBtvk3tA5ShKLgnxifsch
         1nd/itjDzUWlwukxaoq6w6+KPl1GgGawcLj0oZLYvSOmvPXGXegDEeJzI7cvEqSiytni
         FA94UVu+boTGIh5BswOuN/yjIAv/fID5Vd65TszbB9gjQyOkQR2x2IcRuIwQE7OXPb9p
         IDZPrXSeZGp7qEyWV0IULBpQP0S1EZIBwC/yju0PQijfdSd0VWpIHKbW8Zdb+8h3OvCf
         04/YOimgML8QTWmQsa8gMj7eevVT4fdQv8oD+wiYoG4pGQe032UHFBfqgX3i6Kfob6JF
         PpiA==
X-Received: by 10.112.146.129 with SMTP id tc1mr3825336lbb.27.1428101353869;
 Fri, 03 Apr 2015 15:49:13 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 3 Apr 2015 15:49:13 -0700 (PDT)
In-Reply-To: <CAFzU1R+m8Gw3O_HHKmKq0rTALh+TJ1kK84=L2rsGCNft4XcT=Q@mail.gmail.com>
X-Google-Sender-Auth: llw7PdNiBB8sqiIiOGaOPDAJ5-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266746>

[Daniel: Your HTML-formatted response probably did not make it to the
Git mailing list since only plain text is accepted. Also, please
respond inline on this list rather than top-posting.]

On Fri, Apr 3, 2015 at 5:54 PM, Domain Admin <daniel@dbingham.com> wrote:
> I think the context of the patch doesn't make this clear, but if you look at
> git-p4.py in this spot you'll see that this is in a block that begins:
>
> if type_base == "utf16":
>
> Where "type_base" is extracted, by the script, from the filetype provided by
> p4 (i.e. metadata provided by p4). In the particular scenario I encountered,
> P4 said that the file was of type xutf16 from which the split_p4_type()
> method extracts "utf16" as the type_base.

So, the patch's mention of "UTF16 file" indeed refers to the content
rather than the filename.

Now that I've studied up on Perforce a bit and read through some of
the git-p4.py code, I understand that there is a special-case for
files with utf-16 content in which git-p4 re-reads the content in
order to work around a problem with ASCII text saved with type utf-16
getting mangled. The work-around, 55aa5714 (git-p4: handle utf16
filetype properly; 2011-10-17), is buggy in that it neglects to
specify a particular revision of the file, and your patch fixes that.
Perhaps your commit message could make that a bit clearer by
mentioning the special-case and citing 55aa5714? Maybe something like:

    The special-case handling of files with UTF-16 content done by
    55aa5714 (git-p4: handle utf16 filetype properly; 2011-10-17)
    neglects to specify a revision when re-reading the file content.
    As a result, the latest revision of the UTF-16 file is always
    fetched rather than the desired one.

Also, is it possible to craft a test for this issue and place it in
one of the t98xx scripts?

> Daniel
>
> On Fri, Apr 3, 2015 at 2:46 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>>
>> On Fri, Apr 3, 2015 at 5:13 PM, Daniel Bingham <daniel@dbingham.com>
>> wrote:
>> > git-p4 always fetches the latest revision of UTF16
>> > files from P4 rather than the revision at the commit being sync'd.
>> >
>> > The print command should, instead, specify the revision number from the
>> > commit in question using the file#revision syntax.
>> >
>> > The file#revision syntax is preferable over file@changelist for
>> > consistency with how streamP4Files formats the fileArgs list.
>>
>> As a non-Perforce reader trying to understand this patch, there are a
>> couple issues which are unclear or inadequately explained. Perhaps you
>> could provide a bit more detail or cite relevant sources.
>>
>> First, does "UTF16 file" refer to the content or the filename?
>>
>> Second, I may be entirely missing it, but the commit message doesn't
>> seem to explain why this impacts only "UTF16 files", and why this
>> solution is the appropriate fix.
>>
>> If the answer to the first question is that the filename is UTF-16,
>> then would an alternate fix be to convert the value of
>> file['depotFile'] to have the same encoding as the "print -q -o - ..."
>> command-line? (Again, please excuse my Perforce-ignorance if I'm
>> completely off the mark.)
>>
>> > Signed-off-by: Daniel Bingham <git@dbingham.com>
>> > ---
>> >  git-p4.py | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/git-p4.py b/git-p4.py
>> > index ff132b2..156f3a4 100755
>> > --- a/git-p4.py
>> > +++ b/git-p4.py
>> > @@ -2101,7 +2101,8 @@ class P4Sync(Command, P4UserMap):
>> >              # them back too.  This is not needed to the cygwin windows
>> > version,
>> >              # just the native "NT" type.
>> >              #
>> > -            text = p4_read_pipe(['print', '-q', '-o', '-',
>> > file['depotFile']])
>> > +            ufile = "%s#%s" % (file['depotFile'], file['rev'])
>> > +            text = p4_read_pipe(['print', '-q', '-o', '-', ufile])
>> >              if p4_version_string().find("/NT") >= 0:
>> >                  text = text.replace("\r\n", "\n")
>> >              contents = [ text ]
>> > --
>> > 2.3.5
