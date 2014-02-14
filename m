From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 20:04:41 +0100
Message-ID: <52FE68C9.3060403@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>	<52FBC9E5.6010609@gmail.com>	<loom.20140213T193220-631@post.gmane.org>	<52FD4C84.7060209@gmail.com>	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com> <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@chromium.org>,
	Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:04:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEO45-0007Y1-7N
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaBNTEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:04:41 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:36912 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaBNTEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 14:04:39 -0500
Received: by mail-ea0-f174.google.com with SMTP id z10so2657307ead.19
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yxBHdblQG6g7u5sGJMQNQjlBa1ZXdgt7PXpKI9Xiw+k=;
        b=prgQZS2kUMqSg3tANVhwFmZ79D1yBBBkya6XXtzpgOkqR63zwd3iR1YhWgUcMTERmR
         jkPO2Y12WmQZcQcaH3woi5OTxh0u8zgJcWmIflQ8dPYTIO2FGk9ZlbbzlSjXDoGy7Lxz
         UnEJ5p/aToM6Klbsnl+tf1w5wpFvf+AFrNy5NABYGQKyTrJVg203tMzP1I5Dif7stKm2
         nGhZ/QDoeg+G6ve/MAmZmZCOxSBygRBxw4Zp5WFeF439N2451G9+eb/5jW9lMjsQD9Zc
         enXyNc8ZWb6z8R6SuwKrFQN2Cn1P+jXKJmvnGnK2H/lgcFDPmhQU/MlREleRpa/QaC7R
         5e2w==
X-Received: by 10.14.181.134 with SMTP id l6mr11049038eem.8.1392404678770;
        Fri, 14 Feb 2014 11:04:38 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v6sm22956174eef.2.2014.02.14.11.04.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 11:04:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242120>

Am 14.02.2014 00:09, schrieb Zachary Turner:
> To elaborate a little bit more, you can verify with a sample program
> that ReadFile with OVERLAPPED does in fact modify the HANDLE's file
> position.  The documentation doesn't actually state one way or
> another.   My original attempt at a patch didn't have the ReOpenFile,
> and we experienced regular read corruption.  We scratched our heads
> over it for a bit, and then hypothesized that someone must be mixing
> read styles, which led to this ReOpenFile workaround, which
> incidentally also solved the corruption problems.  We wrote a similar
> sample program to verify that when using ReOpenHandle, and changing
> the file pointer of the duplicated handle, that the file pointer of
> the original handle is not modified.
> 
> We did not actually try to identify the source of the mixed read
> styles, but it seems like the only possible explanation.
> 
> On Thu, Feb 13, 2014 at 2:53 PM, Stefan Zager <szager@google.com> wrote:
>> On Thu, Feb 13, 2014 at 2:51 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Am 13.02.2014 19:38, schrieb Zachary Turner:
>>>
>>>> The only reason ReOpenFile is necessary at
>>>> all is because some code somewhere is mixing read-styles against the same
>>>> fd.
>>>>
>>>
>>> I don't understand...ReadFile with OVERLAPPED parameter doesn't modify the HANDLE's file position, so you should be able to mix read()/pread() however you like (as long as read() is only called from one thread).
>>
>> That is, apparently, a bald-faced lie in the ReadFile API doc.  First
>> implementation didn't use ReOpenFile, and it crashed all over the
>> place.  ReOpenFile fixed it.
>>
>> Stefan

Damn...you're right, multi-threaded git-index-pack works fine, but some tests fail badly. Mixed reads would have to be from git_mmap, which is the only other caller of pread().

A simple alternative to ReOpenHandle is to reset the file pointer to its original position, as in compat/pread.c::git_pread. Thus single-theaded code can mix read()/pread() at will, but multi-threaded code has to use pread() exclusively (which is usually the case anyway). A main thread using read() and background threads using pread() (which is technically allowed by POSIX) will fail with this solution.

This version passes the test suite on msysgit:

----8<----
ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
{
	DWORD bytes_read;
	OVERLAPPED overlapped;
	off64_t current;
	memset(&overlapped, 0, sizeof(overlapped));
	overlapped.Offset = (DWORD) offset;
	overlapped.OffsetHigh = (DWORD) (offset >> 32);

	current = lseek64(fd, 0, SEEK_CUR);

	if (!ReadFile((HANDLE)_get_osfhandle(fd), buf, count, &bytes_read, &overlapped)) {
		errno = err_win_to_posix(GetLastError());
		return -1;
	}

	lseek64(fd, current, SEEK_SET);

	return (ssize_t) bytes_read;
}
