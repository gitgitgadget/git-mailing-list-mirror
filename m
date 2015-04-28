From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 13:34:00 -0700
Message-ID: <20150428203400.GN5467@google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
 <20150428201918.GA10902@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: erik =?iso-8859-1?Q?elfstr=F6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:34:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCCo-0008S5-5L
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966126AbbD1UeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2015 16:34:06 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36454 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966059AbbD1UeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:34:04 -0400
Received: by iebrs15 with SMTP id rs15so27986202ieb.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=htnktCcOX7B0kkv9JQr9Lc8JJYnRnQbLhWFhhfV6oLM=;
        b=Uzgc8y8bD/FVtDulMTU4h7FqUCOdXpGCnJoThLKyFcy4MqnhCFYssq+HzUuqG5AwSo
         Kp6HTQlMglR7n5vR+Ch6+Tq/g5Cql57DFI94mJFSDihg4tfRllstBCcGy5bkXjaSO6MI
         DXKQ5am0N+UupeUUGia+sMHFeA3FedXmSy/SUGmfT4DZgq2h+i09uGzp9S8AC0tPXB+Y
         Ombh3KDslvDeU/XZ4viNH2USUnUsjQb0qUqViLDkG4TlYWLk8jYfwIuz4RXSrR8gB2HJ
         5gCZoDOXKKO+VvQIhi0u4zjWn8mDuiXHJrK1Pj//Vch0vgD3oEAJ3cN8lGZj01zeHwN9
         vOwQ==
X-Received: by 10.42.44.71 with SMTP id a7mr20466241icf.14.1430253242713;
        Tue, 28 Apr 2015 13:34:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c979:ad68:d2ca:9e9e])
        by mx.google.com with ESMTPSA id h128sm14705233ioh.38.2015.04.28.13.34.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 13:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150428201918.GA10902@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267941>

Jeff King wrote:
> On Tue, Apr 28, 2015 at 10:07:43PM +0200, erik elfstr=F6m wrote:

>> Also if it turns out that we actually need to treat the "file too
>> large" error differently in clean (as discussed in thread on the fil=
e
>> size check) then we can no longer communicate that back using the
>> strbuf interface.
>
> Yeah, agreed. This system breaks down as soon as you need to
> programatically know which error happened.

On the contrary: it separates the information that is used
programatically and the information intended for the user.

The return value (or an int * parameter) distinguishes errors that
affect control flow.  A string can provide information for the user.

This way it is easy to tweak the information that the user sees in
one place, without changing control flow.
