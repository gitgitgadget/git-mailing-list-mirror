From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 10:24:19 +0100
Message-ID: <CAFXTnz6mU999DBQG9mPKyjtit4e4WF=bUf_E8XwGR8d5sUPO0w@mail.gmail.com>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
	<CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxwZZ-00031n-A8
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 10:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab3AWJYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 04:24:22 -0500
Received: from mail-bk0-f43.google.com ([209.85.214.43]:38381 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab3AWJYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 04:24:21 -0500
Received: by mail-bk0-f43.google.com with SMTP id jf20so4266120bkc.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N5RscBM5fA8oh41Q2K4jtLfMjxRPZ2HW+Hivbmcnou4=;
        b=gNJxw4lPM5GNakCbeS/+j6z/pSetsaZ8CxGZN0vTrxT/ODO1r0EC0gwa4K0qvaqryI
         E8+Ybk4SVwZjdEtawyBdieKRKZR2M27WUeHgyFddOYWsOJzPdWfsmAwP1zJ1QdAeP42E
         fQ4ejwqZ6QWJmYbdL4GhlI+Jkt994vX3v/4IyjxIBnzUWJovDXK2DPzc1EBOad2sJ+Bo
         UThhpdaxGOwlKky3FMhZq67L0pRaQl0ecdFGCbPVIUZUhUt84p1PKB3u09mLec3YkOiF
         v76hQa3zuS5eMM3SH6CBeHJVTQ/2o/w0a54U1gIOcRGe2Tdc+WU/JTtsJy6VVBmk2xRt
         ARpw==
X-Received: by 10.204.149.11 with SMTP id r11mr160747bkv.93.1358933059640;
 Wed, 23 Jan 2013 01:24:19 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Wed, 23 Jan 2013 01:24:19 -0800 (PST)
In-Reply-To: <CACsJy8DskoCi9Lg+HW0JeQBe4HX-bMXNHUgfrsg+DoqBN9-ntQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214304>

On Wed, Jan 23, 2013 at 9:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Perhaps we could add the subrepo's object data to the in-memory object
> database of git-all, then do the diff without launching new commands?

The `git all` command is regularly invoked outside of git repos, so
I'm not sure if this would work.

>
> I'm not a user of this command so this is more of bikeshedding. I
> think we should have an option to list repos listed in index.

git-submodule uses something like `git ls-files --stage|grep
"^160000"`. Having a better way to achieve this would be nice, but I
don't think it is a job for 'git [all|for-each-repo|ls-repo].

> For
> directory walk, how about reusing fill_directory() to do the job for
> you? You could then limit repositories by name. "ls-files -o" code
> should be very similar.

A cursory look into dir.c seems to indicate that this could work
(possibly except for get_index_dtype()), but it would also load the
complete directory tree (which could be extremly big) into ram,
including file entries (which is not necessary) while dropping '.git'
entries (which is what we're looking for).

-- 
larsh
