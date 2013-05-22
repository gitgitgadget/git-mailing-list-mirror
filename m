From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Reading commit objects
Date: Wed, 22 May 2013 11:20:44 -0300
Message-ID: <CABx5MBS9YgNmZD_tumMJ-MJVjHbRFCKbCjs9AZ347-OCwqO7qQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 22 16:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf9uh-0000WD-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab3EVOVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:21:06 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:59663 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab3EVOVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:21:05 -0400
Received: by mail-ve0-f180.google.com with SMTP id c13so1437999vea.25
        for <git@vger.kernel.org>; Wed, 22 May 2013 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HxrQ7Qrsh4I8I8gMMI5uxOTE/OdOhe2GAlNpqzBJ6CE=;
        b=Ao+2+3Bj534d9zxO3Ab82kK5UJIZ/M+dO4Q8zS9o3I0yxDBDQxGuPFAKUXC5ylqHjY
         +82QpJif3B1ivCv7hLOmKso7Msyud0N6NVASHc7SZfNA48HqJpHiZlYtCUY35r94CSV1
         U5qwmtWZmrw6cuj68jhpK3VLw/ejnBybhFVVdCM9k0LhJ6MnJLVUxcsw9qtmGkwT1rMd
         U5lA2RcThw4JIoH8km6sMNLd9u1ZwdDHohTGqf5ICNHN6NKTED4lZ6wmuAxtXUnIHGlE
         fV0H1Qa12swzR2FTx70uxfmKsD5z4TtXWlkqlPKi6xuVamoz04TakLoZiR4Z+hyAc2Fe
         mtVg==
X-Received: by 10.52.36.115 with SMTP id p19mr2443027vdj.8.1369232464273; Wed,
 22 May 2013 07:21:04 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Wed, 22 May 2013 07:20:44 -0700 (PDT)
In-Reply-To: <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225161>

I'm not criticizing JGit, guys. It simply doesn't fit into our needs.
We're not interested in mapping git commands in java and don't have
the same RAM limitations.

I know JGit team is doing a great job and we do not intend to build a
library with such completeness.

Are you guys contributors of JGit? Can you guys point me out to the
code that unpacks git objects? The closest I could get was that class:
https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/UnpackedObject.java

It seems to be a standard and a non standard format of the packed
object, as I read the comments of this method:
https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/UnpackedObject.java#L272

I suspect that the default inflater class of java api expect the
object to be in the standard format.

What the following comment mean? What's the "Experimental pack-based"
format? Is there any docs on the specs of that?

We must determine if the buffer contains the standard
zlib-deflated stream or the experimental format based
on the in-pack object format. Compare the header byte
for each format:
RFC1950 zlib w/ deflate : 0www1000 : 0 <= www <= 7
Experimental pack-based : Stttssss : ttt = 1,2,3,4


--
Chico Sokol


On Wed, May 22, 2013 at 2:59 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, May 21, 2013 at 3:18 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
>> Ok, we discovered that the commit object actually contains the tree
>> object's sha1, by reading its contents with python zlib library.
>>
>> So the bug must be with our java code (we're building a java lib).
>>
>> Is there any non-standard issue in git's zlib compression? We're
>> decompressing its contents with java default zlib api, so it should
>> work normally, here's our code, that's printing that wrong output:
>>
>> import java.io.File;
>> import java.io.FileInputStream;
>> import java.util.zip.InflaterInputStream;
>> import org.apache.commons.io.IOUtils;
>> ...
>> File obj = new File(".git/objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
>> InflaterInputStream inflaterInputStream = new InflaterInputStream(new
>> FileInputStream(obj));
>> System.out.println(IOUtils.readLines(inflaterInputStream));
> ...
>>>> Currently, we're trying to parse commit objects. After decompressing
>>>> the contents of a commit object file we got the following output:
>>>>
>>>> commit 191
>>>> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>>>> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>>>>
>>>> first commit
>
> Your code is broken. IOUtils is probably corrupting what you get back.
> After inflating the stream you should see the object type ("commit"),
> space, its length in bytes as a base 10 string, and then a NUL ('\0').
> Following that is the tree line, and parent(s) if any. I wonder if
> IOUtils discarded the remainder of the line after the NUL and did not
> consider the tree line.
>
> And you wonder why JGit code is confusing. We can't rely on "standard
> Java APIs" to do the right thing, because commonly used libraries have
> made assumptions that disagree with the way Git works.
