From: Shawn Pearce <spearce@spearce.org>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 18:49:08 -0700
Message-ID: <BANLkTi=9vp+ibVa3tQzXbZSeYATKwmF60Q@mail.gmail.com>
References: <4DD02876.1040404@bbn.com> <20110515201608.GX6349@kiwi.flexilis.local>
 <4DD12517.1000308@bbn.com> <BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin L Resnick <mresnick@bbn.com>,
	"R. Tyler Croy" <tyler@monkeypox.org>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 03:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM9Pj-0001r9-BD
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 03:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab1EQBt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 21:49:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50458 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1EQBt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 21:49:29 -0400
Received: by vws1 with SMTP id 1so31712vws.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 18:49:28 -0700 (PDT)
Received: by 10.52.181.69 with SMTP id du5mr104707vdc.113.1305596968114; Mon,
 16 May 2011 18:49:28 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Mon, 16 May 2011 18:49:08 -0700 (PDT)
In-Reply-To: <BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173781>

On Mon, May 16, 2011 at 18:32, Sitaram Chamarty <sitaramc@gmail.com> wr=
ote:
> On Mon, May 16, 2011 at 6:52 PM, Martin L Resnick <mresnick@bbn.com> =
wrote:
>> Thanks for the reply.
>>
>> But gitolite would only work to deny reads on a repository or ref ba=
sis
>> not a pathname level.
>
> I notice the original question has been answered, so this email is
> just for the record.
>
> Gitolite does not do any access control on *read* access (fetch,
> clone). =A0It can only do that on *write*s (push).
>
> Gerrit does that because they've reimplemented git itself and have
> coded that into their git engine somehow. =A0I believe they had to
> implement a callback from jgit to gerrit for the fetch,

Yes, we do.

> and deal with
> evil clients that might try to read an object by pushing a supposed
> change on top of a SHA that they know but don't actually have. (Or
> something like that; I'm not real clear on this...).

Yes, we also have protections for this. Users cannot push objects that
reference objects they are not allowed to read. This check needs to be
done for delta bases as well as commit tree/parent pointers, and tree
entries. Its not difficult, but its not as simple as just limiting the
branch names shown to upload-pack.

> PS: Gitolite does have unreleased code to do this but it's a hack wit=
h
> several limitations. =A0Gitolite makes a temp "clone -l", deletes all
> refs from it that the user has no access to, then redirects the
> git-upload-pack to that repo instead ;-)

Cute hack. Doesn't prevent the evil client from making an indirect
reference to something you shouldn't have. :-)

--=20
Shawn.
