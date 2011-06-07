From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Tue, 07 Jun 2011 15:05:00 -0700
Message-ID: <7vr57547sj.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
 <7vvcwi95yi.fsf@alter.siamese.dyndns.org>
 <loom.20110606T213817-376@post.gmane.org>
 <7v1uz55r24.fsf@alter.siamese.dyndns.org>
 <loom.20110607T224355-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Neronskiy <zakmagnus@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU4Oi-0002gv-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758800Ab1FGWFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 18:05:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758763Ab1FGWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 18:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13F3F5BFF;
	Tue,  7 Jun 2011 18:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q7BpNU7K/Ppe2QTK7+L2f8bhbcg=; b=AaCqJq
	EnMlo+QtjYUO+C2rslg114IfUZ0rO6AGEK3BGmN7LQbocAm4esSUrpq4EUrHbN/d
	M6vdGDwafYZf+he5YEpRknDQWZmJLAHfs8XvCph+Fur1wddcKuRsMARswBotxZf9
	5a+PcO3ViQBQSwxBffKck6Aye60JCEK8R1fJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZB5uwW6DLGlM7tqE5sAQxUsl0A6cwh2s
	3RszCiQxh2aCo74FvFWKpVVoRaiIchP5KFiy7bie/EJrRnTJK5kZariVsrfSHZFE
	f4AFwP8U/H+iGjO/0TZFcCDRK4xs6Y+pFy0WULYMFDF0KrNiD88DNUMzNdxXK+tV
	3eJegu+NkKs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E578A5BFE;
	Tue,  7 Jun 2011 18:07:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E604F5BFD; Tue,  7 Jun 2011
 18:07:11 -0400 (EDT)
In-Reply-To: <loom.20110607T224355-216@post.gmane.org> (Alex Neronskiy's
 message of "Tue, 7 Jun 2011 20:47:34 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E8B0C92-9152-11E0-B26C-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175271>

Alex Neronskiy <zakmagnus@google.com> writes:

> The part of the document I'm referring to starts at line 221 and reads: 
>
>  Once all the "want"s (and optional 'deepen') are transferred,
>  clients MUST send a flush-pkt. If the client has all the references
>  on the server, client flushes and disconnects.
>
> And I believe this refers to the code path beginning at line 308 of fetch-pack.c:
>
>         if (!fetching) {
>                 strbuf_release(&req_buf);
>                 packet_flush(fd[1]);
>                 return 1;
>         }
>
> Am I wrong? 

Ah, I overlooked that codepath, but if that if statement triggered, that
would mean fetching is still 0, which in turn means that you never sent
any "want", so "Once all the 'want's' (and optional 'deepen') are
transferred" is not even true, is it?
