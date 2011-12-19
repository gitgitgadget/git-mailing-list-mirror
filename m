From: Stephen Major <smajor@gmail.com>
Subject: Re: post-receive for web deployment
Date: Mon, 19 Dec 2011 04:42:37 -0800
Message-ID: <CALzTOmJacwJFNJJo6Y7kjq2pVP8DcgYfWf=bsD0m9oK1XsZ9Yw@mail.gmail.com>
References: <CALzTOmJUqzO8H5UxyFaodi98DBJtFvsbQsHsYh1U=Ggq3NRO5A@mail.gmail.com>
	<CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
	<CAMK1S_hjncBxdh4+UXAJbtJnsPWZUpWASyixG8eNcpFLMRpLgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 13:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RccYM-0003pr-J4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 13:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab1LSMmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 07:42:40 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62308 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1LSMmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 07:42:38 -0500
Received: by qcqz2 with SMTP id z2so3033086qcq.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 04:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PlWEuNtYat6tiUrzT3bXvelS6RkE+TykA0uOgU6qv2g=;
        b=i+cIY6RkLETXhKPvykMtIl0NT5scqqnEtQVp+n0Awpf5tvbaoChpZABmD51xdm17hx
         FxVOK7F6YvIZ++Q4sjQnNn39MhWfz1JkyR8c3rCqBul/rCoICl2ZV0J+lnXWGkmrN0NF
         1aZ6iC/+d/f3a0AW82QBllGcM53kaDcfHQtv0=
Received: by 10.229.77.134 with SMTP id g6mr5379936qck.125.1324298557651; Mon,
 19 Dec 2011 04:42:37 -0800 (PST)
Received: by 10.229.33.67 with HTTP; Mon, 19 Dec 2011 04:42:37 -0800 (PST)
In-Reply-To: <CAMK1S_hjncBxdh4+UXAJbtJnsPWZUpWASyixG8eNcpFLMRpLgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187449>

After some playing I found using git clone to export to the staging
path and then doing git checkout -f master for the production path
keeps the files in the production tree clean while leaving any
un-tracked files in tact, seems what
Johannes said was true and this seems like a simple workaround... not
sure about working with indexes like he pointed out.

echo "Resetting staging tree"
rm -rf staging.git $staging_path
git --work-tree=3D$staging_path clone ./ staging.git


echo "Resetting production tree"
git --work-tree=3D$live_path checkout -f master


On Mon, Dec 19, 2011 at 2:35 AM, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:
> On Mon, Dec 19, 2011 at 8:12 AM, Stephen Major <smajor@gmail.com> wro=
te:
>> Hello,
>>
>> I am having some difficulty understanding what I am doing wrong when
>> working with git to deploy a website through the use of a post-recei=
ve
>> hook on the remote.
>
> The most common issue I have seen in cases like this is that you need
> to 'unset GIT_DIR'. =A0In fact, anytime you play around with running
> stuff from *inside* a hook that works fine when you run it from
> outside, you need to check what GIT_ variables are present.
>
> I believe 'unset `git rev-parse --local-env-vars`' is a good idea too=
;
> probably much simpler.
