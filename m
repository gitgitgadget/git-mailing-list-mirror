From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Sun, 15 Mar 2015 07:17:07 +0700
Message-ID: <CACsJy8CK=0QpsMpZKN6Js99xFRD6mpJW1id2BBQDMsV1DaHiPg@mail.gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com> <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com> <55016A3A.6010100@alum.mit.edu>
 <20150312104651.GF46326@vauxhall.crustytoothpaste.net> <CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
 <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com> <CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
 <xmqqwq2lzb6u.fsf@gitster.dls.corp.google.com> <CACsJy8BeFO3RQJ6pU5+q6E4n3A36X9PgYoi7xB_NQ4C_JYaP5w@mail.gmail.com>
 <xmqqbnjvw7c8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 01:17:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWwFV-0004cs-Ev
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 01:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbbCOARk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 20:17:40 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38867 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbbCOARi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 20:17:38 -0400
Received: by igbue6 with SMTP id ue6so14151299igb.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ck4LAvmEPpssO6a6USjHd4aTtSuOyHqfveOOs/4H9HU=;
        b=jvvNazm4mf/e9a0HhJ3zDltOWeMzDGQmtER6GamHUt22JuyuoklLks1iEHyi0kqtDp
         cQ4IeKCSlSBgL21k3aD3r4A71DRk5LAigdy/QlF+aZQIY6Ha0h7eo3D+SHkrHEUir2Je
         75Vgmzi1iqB5Gi1+yxYzgfzXn5sAje6ReLfOt6p/PPYMAH23zV/QvxJXHWq0zk2lXDn5
         trbrZiU2Mz8vF45RAg0qlvyFXcfInbR/wUUUhaOOdfAoc7hVO/bsnT5pIGCPI1jHdCw2
         VR7T9H13m4Men8ZSahVSkzP2bGALUQLcWXZcsP72e4GJEUK+zlistmiBt/f3NA2M5DKt
         mW6Q==
X-Received: by 10.107.153.193 with SMTP id b184mr97703454ioe.85.1426378657645;
 Sat, 14 Mar 2015 17:17:37 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 17:17:07 -0700 (PDT)
In-Reply-To: <xmqqbnjvw7c8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265471>

On Sun, Mar 15, 2015 at 5:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> Anyway, wouldn't this be all academic?  I do not see how you would
>>> keep the object name in the <pack, nth> format in-core, as the
>>> obj_hash[] is a hashtable keyed by <sha-1>, and even when we switch
>>> to a different hash, I cannot see how such a table to ensure the
>>> singleton-ness of in-core objects can be keyed sometimes by <hash>
>>> and by <pack, nth> in some other time.
>>
>> I'm implementing something to see how much we gain by avoiding object
>> lookup. The current approach is having "struct object ** obj" in
>> "struct packed_git", indexed by "nth". So when you have <pack, nth>
>> and pack->obj[nth] is valid, you'll get to "struct object *" without
>> hashing.
>
> But do you realize that the hashtable serves two purposes?  Grab the
> object from its name is one thing, and the other one I am not seeing
> how you will make it work with "sometimes <sha-1> sometimes <pack,nth>"
> is to ensure that we will have only one in-core copy for the same object.
> We even walk the hashtable when we want to drop the flag bits from
> all in-core objects, so even if you instanciated an in-core object
> without going through the object name layer, the hashtable needs to
> have a pointer to such a pointer, no?

Notice that the first time pack->obj[] is filled using
lookup_object(). So yes, the hash table has all the pointers that
pack->obj[] has. If somebody wants to remove an object out of hash
table, then all pack->obj[] are invalidated, but I don't think we ever
delete objects from hash table.
-- 
Duy
