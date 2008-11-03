From: "Thanassis Tsiodras" <ttsiodras@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Tue, 4 Nov 2008 00:53:42 +0200
Message-ID: <f1d2d9ca0811031453p49390911p956149ca76b9b80d@mail.gmail.com>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
	 <m37i7pggnk.fsf@localhost.localdomain>
	 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
	 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
	 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
	 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
	 <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
	 <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:55:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx8K3-0005EJ-6T
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYKCWxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYKCWxp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:53:45 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:58437 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbYKCWxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:53:44 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1072045ywe.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 14:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8k8PQZWG1Y/05SDlosYM2sK6Ah5OWzAza/XWdfOwyrQ=;
        b=W1xhLG4OSCJM/DnxjqJ0jXgRV3trud/sALNr2gZSOTArgRxB2Jkf14aILYV7vUzftY
         dlkPTV9NFQjJKfUeOraSbfA4ALTkoKfJniVgoZvo/vx7wne3MJYA1/nAORWHivuNGCNH
         i7WM92qVqbs0GFznLL6HOvm+Ro9ZnEoqDCVEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fNfc10p8ARF1gUPXuHMicrqhYn71KnxdoOA0hrZdklbjk9Saw4OmTSaLSUhqupCUza
         l0/sBJJ2q4F6HqvbBkdQ+ZxUIU3A5hejJosHq7gY1YuwMLez5+bJJ5K1FUlCW6AAMIzm
         Kwrxl0jUQjvO8zbeYThfcIJxDnJ55LhiCCO4I=
Received: by 10.100.107.17 with SMTP id f17mr286419anc.51.1225752822422;
        Mon, 03 Nov 2008 14:53:42 -0800 (PST)
Received: by 10.100.11.13 with HTTP; Mon, 3 Nov 2008 14:53:42 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100007>

RESOLVED!!!

Finally...
What happened was actually quite reasonable, in hindsight...
As I said in the original mail, this was what I did:

cp version7.1.tar version7.2.tar
git add version7.2.tar
git commit -m "same data as old, so git will use old blob"
echo MAGICPLACE read below...
cp /path/to/work/realNewVersion7.2.tar version7.2.tar
git add version7.2.tar
git commit -m "and now, commit the really new version, so git can xdelta"
git push --thin

The problem was solved (that is, the "git push" became optimal,
when I added a "git push" right after the MAGICPLACE mark above...
In that way, the remote repo learned about the "dummy" commit that
referenced the old blob... and when I did the subsequent "git push"
at the end, the remote side could see that it already had this "dummy"
commit to "xdelta on", and that it only needed the delta...

Originally, when I used only one "git push --thin" at the end, the remote
side didn't have the "dummy" commit, so it probably said: "I can't
apply a delta, give me the full object".

Phew.

So it seems that if you must introduce a new file that is
very similar to an existing one (in my case, a new version
of software kept in an uncompressed .tar file),
you have to do what I did above to allow for optimal "git push"es:
that is:

1. Create the new filename by just copying the old
 (so the old blob is used)
2. commit
3. PUSH
4. copy the real new file
5. commit
6. PUSH.

If you omit the middle PUSH in step 3, neither "git push", nor "git push --thin"
can realize that this new file can be "incrementally built" on the remote side
(even though git-gc totally squashes it in the pack).

Thanks to all the people who responded, and especially Nicolas...
Merci!


On 11/3/08, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 3 Nov 2008, Thanassis Tsiodras wrote:
>
>> Despair...
>>
>> I just tested "git push --thin"...
>> Doesn't work.
>>
>> It still sends the complete object, not a tiny pack as it could (should).
>>
>> But perhaps I now understand why:
>>
>> I run git-gc on both the remote end and the working end (before
>> changing anything,
>> i.e. with both repos being in sync - "git pull" and "git push" report all
>> OK).
>> I then noticed that on the remote side, .git/objects/pack had one big pack
>> file,
>> but on the local one I have two .pack files...!
>>
>> I proceeded to try (many combinations of params on) git-repack in a vain
>> attempt
>> to make my local repos also have one single .pack file (presumably, it
>> should be able
>> to exactly mirror the remote one, since it has the same objects inside
>> it!). No way...
>
> Please stop thinking that your repository layout has anything to do with
> what is actually transferred on a push.  It has not.
>
> Here's a small test that you can do locally:
>
> 	mkdir repo_a
> 	mkdir repo_b
> 	cd repo_a
> 	git init
> 	seq 1000000 > data
> 	git add data
> 	git commit -m "initial commit"
> 	cd ../repo_b
> 	git init
> 	cd ../repo_a
> 	git push ../repo_b master:master
>
> Here you should see a line that says:
>
> 	Writing objects: 100% (3/3), 2.01 MiB, done.
>
> Therefore 2.1 MiB were transferred.  Now let's continue:
>
> 	echo "foo" >> data
> 	git add data
> 	git commit -m "second commit"
> 	git push ../repo_b master:master
>
> You should get:
>
> 	Writing objects: 100% (3/3), 423 bytes, done.
>
> And this means that you even don't need the --thin switch (which is
> wrong -- this has been broken before but that's another story) for the
> transfer to actually send only the difference and not the whole file
> again.  And note that none of those repositoryes actually contain any
> pack as everything is still loose objects.
>
>> I'm at a loss as to why the two repos are having different "pack
>> representation" of the same objects
>
> That's only because those objects entered each repositories in a
> different way.
>
>> and why git-gc and git-repack fail
>> to create a single pack on my working side,
>
> Maybe you have a .keep file in .git/objects/pack/ ?  If so delete it and
> run 'git repack -a -d'.
>
>> but I'm guessing that this is why "git push --thin" fails to send
>> small xdeltas...
>
> Not at all.
>
> Please provide a complete log of your tests and maybe we could find
> something.
>
>
> Nicolas
>


-- 
What I gave, I have; what I spent, I had; what I kept, I lost. -Old Epitaph
