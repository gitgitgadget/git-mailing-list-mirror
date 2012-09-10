From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Mon, 10 Sep 2012 13:48:53 +0200
Message-ID: <504DD3A5.8000201@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu> <7voblfsfmd.fsf@alter.siamese.dyndns.org> <504D7082.9020903@alum.mit.edu> <7vhar6pgxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 13:49:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB2UF-0001yr-5A
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 13:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab2IJLs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 07:48:57 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:46139 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047Ab2IJLs4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 07:48:56 -0400
X-AuditID: 1207440f-b7fde6d00000095c-e2-504dd3a7ed43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id BF.CD.02396.7A3DD405; Mon, 10 Sep 2012 07:48:55 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ABmrCc026836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 07:48:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vhar6pgxs.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqLv8sm+AweddOhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xqyNKgUrVSv+ztrP3MC4WLaLkZNDQsBEoudK
	LzuELSZx4d56ti5GLg4hgcuMEj9mbGKHcI4zSUw51cQGUsUroC2xZsEcFhCbRUBV4uOmzYwg
	NpuArsSinmYmEFtUIERixuXJzBD1ghInZz4BqxcRUJOY2HYIyObgYBYQl+j/BxYWFvCU2Nay
	kAVi13tGiX39R8F6OQXMJM5s/8wKYjML6Ei863vADGHLS2x/O4d5AqPALCQrZiEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkDDl38HYtV7mEKMAB6MSD+9N
	fd8AIdbEsuLK3EOMkhxMSqK8Py8AhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw/tkLlONNSays
	Si3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfA+vgTUKFiUmp5akZaZU4KQZuLg
	BBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9n4DaectLkjMBYpCtJ5i1OW4+3HFfUYhlrz8
	vFQpcd6tIEUCIEUZpXlwK2BJ6RWjONDHwryXQap4gAkNbtIroCVMQEt8PXxAlpQkIqSkGhgb
	L3tdPGCWzHGIae0R+9RjDgn565dY3NdxS/pV43jl1ZO3p2Zfnq/UaJS+ceddvr4dXuJay76Y
	Np5sEBR8aud/3nTt3pP/q+2n3i+5EDz38M6lHTUvT/v8mx3sKjPb6dm7lffN5u/N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205119>

On 09/10/2012 07:47 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> ...  Consider something like
>>
>>     struct string_list *split_file_into_words(FILE *f)
>>     {
>>         char buf[1024];
>>         struct string_list *list = new string list;
>>         list->strdup_strings = 1;
>>         while (not EOF) {
>>             read_line_into_buf();
>>             string_list_split_in_place(list, buf, ' ', -1);
>>         }
>>         return list;
>>     }
> 
> That is a prime example to argue that string_list_split() would make
> more sense, no?  The caller does _not_ mind if the function mucks
> with buf, but the resulting list is not allowed to point into buf.
> 
> In such a case, the caller shouldn't have to _care_ if it wants to
> allow buf to be mucked with; it is already asking that the resulting
> list _not_ point into buf by setting strdup_strings (by the way,
> that is part of the function input, so think of it like various *opt
> variables passed into functions to tweak their behaviour).  If the
> implementation can do so without sacrificing performance (and in
> this case, as you said, it can), it should take "const char *buf".

You're right, I was thinking that a caller of
string_list_split_in_place() could choose to remain ignorant of whether
strdup_strings is set, but this is incorrect because it needs to know
whether to do its own memory management of the strings that it passes
into string_list_append().

> So it appears to me that sl_split_in_place(), if implemented, should
> be kept as a special case for performance-minded callers that have
> full control of the lifetime rules of the variables they use, can
> set strdup_strings to false, and can let buf modified in place, and
> can accept list that point into buf.

OK, so the bottom line would be to have two versions of the function.
One takes a (const char *) and *requires* strdup_strings to be set on
its input list:

int string_list_split(struct string_list *list, const char *string,
		      int delim, int maxsplit)
{
	assert(list->strdup_strings);
	...
}

The other takes a (char *) and modifies it in-place, and maybe even
requires strdup_strings to be false on its input list:

int string_list_split_in_place(struct string_list *list, char *string,
			       int delim, int maxsplit)
{
	/* not an error per se but a strong suggestion of one: */
	assert(!list->strdup_strings);
	...
}

(The latter (modulo assert) is the one that I have implemented, but it
might not be needed immediately.)  Do you agree?

>>>> + * Examples:
>>>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
>>>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
>>>> + *   string_list_split_in_place(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
>>>
>>> I would find it more natural to see a sentinel value against
>>> "positive" to be 0, not -1.  "-1" gives an impression as if "-2"
>>> might do something different from "-1", but Zero is a lot more
>>> special.
>>
>> You have raised a good point and I think there is a flaw in the API, but
>> I'm not sure I agree with you what the flaw is...
>>
>> The "maxsplit" argument limits the number of times the string should be
>> split.  I.e., if maxsplit is set, then the output will have at most
>> (maxsplit + 1) strings.
> 
> So "do not split, just give me the whole thing" would be maxsplit == 0
> to split into (maxsplit+1) == 1 string.  I think we are in agreement
> that your "-1" does not make any sense, and your documentation that
> said "positive" is the saner thing to do, no?

No.  I think that my handling of maxsplit=0 was incorrect but that we
should continue using -1 as the special value.

I see maxsplit=0 as a legitimate degenerate case meaning "split into 1
string".  Granted, it would only be useful in specialized situations
[1].  Moreover, "-1" makes a much more obvious special value than "0";
somebody reading code with maxsplit=-1 knows immediately that this is a
special value, whereas the handling of maxsplit=0 isn't quite so
blindingly obvious unless the reader knows the outcome of our current
discussion :-)

Therefore I still prefer treating only negative values of maxsplit to
mean "unlimited" and fixing maxsplit=0 as described.  But if you insist
on the other convention, let me know and I will change it.

Michael

[1] A case I can think of would be parsing a format like

    NUMPARENTS [PARENT...] SUMMARY

where "string_list_split(list, rest_of_line, ' ', numparents)" does the
right thing even if numparents==0.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
