From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 19:04:28 +0200
Message-ID: <4AD3619C.6010808@gmail.com>
References: <loom.20091012T115746-719@post.gmane.org> <4AD31EBF.6090307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxOVN-0002mb-4D
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 19:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbZJLRFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932974AbZJLRFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:05:16 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:60950 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972AbZJLRFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 13:05:13 -0400
Received: by fxm27 with SMTP id 27so9415569fxm.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=IWAVxjtp3v3rACqA2ugnlBtOI3S+B2+0oKGhGvQRLIw=;
        b=NO9U5LITw6M7CpAABRuPvMgh1PUYEthOHpeurHlXfP551Go1BafMju8fdgN6I1r6fQ
         2KGduMq2uhFGd1bKbU3Ix7d3DQE+CepzOsTe+ddALFeeWrh7BzSN3OnUvaCQcN8rntAa
         N45Qt8JQoTGjnahumEz0qQ4Up6FNrTjf/IVqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AMVHk92B/aMHdhe3JyZ6T1MGEQomYGzlxa1T0eAguEbh27w6cjbUISeN+udgmTokiz
         Z3s/9XGiyns+BOGoI22dIPoKhqSMlfnZ43PG4134jnhkfSldFvgAp2fG+BXw+dLjpxGZ
         2c6OFrCsyl+BLgp8t/sIS4MPZhVvHR+UQT3TI=
Received: by 10.204.25.152 with SMTP id z24mr5314261bkb.44.1255367074428;
        Mon, 12 Oct 2009 10:04:34 -0700 (PDT)
Received: from ?10.143.20.223? (mars-fw.arces.unibo.it [137.204.143.2])
        by mx.google.com with ESMTPS id z10sm6161892fka.3.2009.10.12.10.04.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 10:04:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AD31EBF.6090307@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130035>

Thanks Johannes for all the detailed explanations

Johannes Sixt <j.sixt <at> viscovery.net> writes:

 >
 > Sergio schrieb:
 > > 1) Grafts and replace entries seem to operate on different aspects 
of the
 > > history graph. Grafts operate on arcs and replace on nodes.
 >
 > Correct, but see below about tree and blob objects.

OK, the replace mechanism also can replace a blob object or a tree.
My focus was on commit objects only.

 >
 > > As such, replace entries seem less general to me.
 >
 > With grafts you can only change parenthood; with replace entries you can
 > change parenthood *and* all other aspects of a commit (message, author,
 > committer, dates).
 >
 > Hence, replace entries are more general than grafts.

Limiting the discussion to commit objects, I think there are two 
possible scenarios.

1) You create new commits objects as needed
2) You do not.

If you follow 1), I believe grafts and replace entries have exactly the same
flexibility.

If I happen not to like commit B in A---B---C and I want A---B'---C 
where B' has
completely different aspects from B I can either replace B by B' or 
graft away
B, pretending that the parent of A is B

But there are many things that can be done with grafts merely adding a graft
(e.g. cutting away a part of history, joining history),  that cannot be done
with replace entries without creating new commits objects.

I was asking because I was wandering whether replace entries were first 
or later
meant to make grafts deprecated. I hope not, because for a few things 
working on
arcs seems still nice.

 > > Apparently, to simulate a graft with replace entries, you need to 
introduce
 > > extra commit objects. For instance, if object B has no parents, to 
pretend >
 > Yes. Use git-cat-file + edit + git-hash-object as explained in this
 > message just the other day:
 > 
http://thread.gmane.org/gmane.comp.version-control.git/129727/focus=129907

Thanks, good pointer. I missed this!

 > > Conversely, I guess
 > > you can always simulate a replace entry with the graft mechanism, 
without the
 > > need to add any extra commit object. Am I overlooking something?
 >
 > You cannot; see above.

Well, I meant for what regards commit objects only.

If I want to replace some commit X by some commit X' I merely need to 
modify the
parent information of all the commits that are child of X so that they 
pretend
to be child of X', or am I missing something?

 > You can even replace tree objects and blob objects
 > using replace entries, IIUC, but you cannot do that with grafts.

Definitely right!
 
 > > 2) Is it currently possible to use a replace entry to replace a 
commit object
 > > with nothing? Namely if B has A as its sole parent, is it possible 
to have a
 > > replace entry such as A-sha1 becomes null, to pretend that B is a 
hierarchy
 > > root? 
 >
 > Sure. Just make a commit object that does not have parents.

OK, you need to create a new commit object. At the beginning for some 
reason I
thought that you could replace an object
with "nothing" or 00000000000000000000000000000000000000000000

 > > 3) If I remember correctly, there was a reason why grafts were not 
considered
 > > suitable for transferring across repos. Can someone remind me about 
it? How
 > > does the replace mechanism address this issue?
 >
 > The problem with grafts was that, for example, git-pack-objects 
obeyed the
 > graft, and could create a broken repository by removing grafted-away
 > objects. And since git-fsck also obeyed the graft, it did not notice the
 > breakage.
 >
 > OTOH, history walkers (upload-pack, send-pack, pack-objects) and fsck
 > never obey replace entries in the history. But they do keep track of them
 > (and the history that they reference) because they are referenced 
from the
 > refs/replace namespace.
 >

Thanks for the explanation. Can this be made possible for grafts too? 
Wouldn't
it be a matter of having history walkers never obey grafts but keep track of
them (i.e. of the history of the parenthood they reference)?

Like we have "annotated" or heavyweight tags living as objects in the 
database,
would it be possible or make sense to have annotated grafts or replace 
entries,
so that one can express why, by whom and when history was changed?
