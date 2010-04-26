From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Unable to coax hooks into working
Date: Mon, 26 Apr 2010 11:11:15 -0700
Message-ID: <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com>
References: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:11:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Smj-0003V9-2x
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab0DZSLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 14:11:37 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41224 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab0DZSLg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 14:11:36 -0400
Received: by qyk9 with SMTP id 9so17766027qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=I/bb7mb8yTbhZciUXpuGsfz++Asxjw0xZ1S8xYr+lCM=;
        b=t+v2NT6xom/ofIjI+rTRK2ZmRquCLeTD+B4fm/8JqiweRZ9eroSNPGEvxPXcUVn1Az
         fB2csQVz/dfvpH23yQELz97HpDK1wwJr9n629eK3ElfsbrHrQpOfroLrcK43563pJL15
         H3ujPjZ5CFEgzSoGCkHyVDUZvRes0Y5VyYZIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WoPJzziLb0xAlVaXcfjKD/RUxH8ZvGUBKGuyOT0SgVnhZp7gLrSSMAVBWLk77uz8ev
         fe4XLHjdviPK9II5p+f1T6oPwgqMNc19Arkn/CT4CW/9spdkYARHOhLD6IJyv42omgkB
         K8uqKNSmWdk0QUG00U5yY3WvWw0yzEh5BTgP4=
Received: by 10.224.14.137 with SMTP id g9mr1350062qaa.182.1272305495240; Mon, 
	26 Apr 2010 11:11:35 -0700 (PDT)
Received: by 10.229.50.72 with HTTP; Mon, 26 Apr 2010 11:11:15 -0700 (PDT)
In-Reply-To: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145842>

On Mon, Apr 26, 2010 at 11:04, Jeremiah Foster
<jeremiah.foster@pelagicore.com> wrote:
>
>
>>> =C2=A0 =C2=A0 =C2=A0We're using debian testing and git 1.7.0.2 with=
 the http-smart backend.
>>>
>>> =C2=A0 =C2=A0 =C2=A0What should I do to get hooks working?
>>
>> Use the right hook.
>>
> I followed that document I listed explicitly. After lining up the rig=
ht command, the right hook, and the right location, including correct e=
xecutable bits as well as script ownership, a functioning script was bu=
ilt. Yet when the corresponding git command was called, the command fai=
led to send data to the client which leads me to believe that the hooks=
 wasn't called.
>
> Here is so more information on the http backend I was referring to: p=
rogit.org/2010/03/04/smart-http.html
> And the manual page: www.kernel.org/pub/software/scm/git/docs/git-htt=
p-backend.html
>
> Can I confirm that hooks work with this type of transport?
>
> Jeremiah
>

The real problem is that you're using a post-commit hook (or at least
everything you said in your original email implies you are).
post-commit hooks are only triggered in your _local_ repository, since
this is the only place you actually commit.  Doesn't matter which
transport you're using, post-commit will never be triggered by a push.

You want one of the receive, or update hooks, if you're putting this
in a central place, where it needs to be triggered by someone doing a
push in to the repo.
