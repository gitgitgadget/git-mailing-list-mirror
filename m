From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git repository size / compression
Date: Fri, 09 Sep 2011 07:54:55 -0700 (PDT)
Message-ID: <m339g5u5pm.fsf@localhost.localdomain>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	<1315556595.2019.11.camel@bee.lab.cmartin.tk>
	<CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R22Tv-0003nS-VB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914Ab1IIOy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 10:54:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65393 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758855Ab1IIOy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 10:54:58 -0400
Received: by fxd22 with SMTP id 22so698437fxd.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1Aip6p7OBwooLJj4V7zEXw1XQNvD/4EcL8+SFdS3ht4=;
        b=t6Mr1t/gwfEdNiGsmYwicYNHPOqQEzeB95KdBIkTe9Uva3qf7oMhnyBZnFIS/zWN9B
         YLenkM/NRj7mCOjECN2YPSTQ0NXEV3RBqi6ClN3hZKlbNZ5xPZpWP47dIkZUQXXONIuQ
         8OxczomiJFgAIH+jWc1NIf4FcNxQvtWqnwGWU=
Received: by 10.223.76.15 with SMTP id a15mr580556fak.35.1315580097133;
        Fri, 09 Sep 2011 07:54:57 -0700 (PDT)
Received: from localhost.localdomain (abwf200.neoplus.adsl.tpnet.pl [83.8.229.200])
        by mx.google.com with ESMTPS id h23sm2955091fah.26.2011.09.09.07.54.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Sep 2011 07:54:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p89EsTN9008142;
	Fri, 9 Sep 2011 16:54:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p89EsD86008134;
	Fri, 9 Sep 2011 16:54:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181074>

neubyr <neubyr@gmail.com> writes:
> On Fri, Sep 9, 2011 at 3:23 AM, Carlos Mart=EDn Nieto <cmn@elego.de> =
wrote:
> > On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:

>>> I have a test git repository with just two files in it. One of the
>>> file in it has a set of two lines that is repeated n times.
>>> e.g.:
>>> {{{
>>> $ for i in {1..5}; do cat ./lexico.txt>> lexico1.txt && =A0cat
>>> ./lexico.txt>> lexico1.txt && mv ./lexico1.txt ./lexico.txt; =A0don=
e
>>> }}}
>>>
>>
>> So you've just created some data that can be compressed quite
>> efficiently.
>>
>>> I ran above command few times and performed commit after each run. =
Now
>>> disk usage of this repository directory is mentioned below. The 419=
M
>>> is working directory size and 2.7M is git repository/database size.
>>>
>>> {{{
>>> $ du -h -d 1 .
>>> 2.7M =A0 =A0./.git
>>> 419M =A0 =A0.
>>>
>>> }}}

Have you tried the same but with

   $ git gc --prune=3Dnow

before running `du`?

>>> Is it because of the compression performed by git before storing da=
ta
>>> (or before sending commit)??
>>
>> Yes. Git stores its objects (the commit, the snapshot of the files,
>> etc.) compressed. When these objects are stored in a pack, the size =
can
>> be further reduced by storing some objects as deltas which describe =
the
>> difference between itself and some other object in the object-db.
>=20
> Does git store deltas for some files? I thought it uses snapshots
> (exact copy of staged files) only.

When creating packfile from loose objects (e.g. via `git gc`), it
does perform delta compression.

--=20
Jakub Nar=EAbski
